local M = {}

M.bg = "#000000"
M.fg = "#ffffff"

local uv = vim.uv or vim.loop

---@param c string
---@return number[]
local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end
M.rgb = rgb

--- Blend two colors.
---@param foreground string
---@param alpha number|string 0 gives `background`, 1 gives `foreground`. A hex string like "44" is read as a byte.
---@param background string
function M.blend(foreground, alpha, background)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg, fg = rgb(background), rgb(foreground)
  local function channel(i)
    local v = alpha * fg[i] + (1 - alpha) * bg[i]
    return math.floor(math.min(math.max(0, v), 255) + 0.5)
  end
  return string.format("#%02x%02x%02x", channel(1), channel(2), channel(3))
end

--- Blend toward the theme background. Low `amount` = mostly background.
function M.blend_bg(hex, amount, bg)
  return M.blend(hex, amount, bg or M.bg)
end
M.darken = M.blend_bg

--- Blend toward the theme foreground. Low `amount` = mostly foreground.
function M.blend_fg(hex, amount, fg)
  return M.blend(hex, amount, fg or M.fg)
end
M.lighten = M.blend_fg

---@param hex string
---@return number h, number s, number l
local function to_hsl(hex)
  local c = rgb(hex)
  local r, g, b = c[1] / 255, c[2] / 255, c[3] / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s, l = 0, 0, (max + min) / 2
  if max ~= min then
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)
    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h / 6
  end
  return h, s, l
end

local function from_hsl(h, s, l)
  local function hue(p, q, t)
    if t < 0 then
      t = t + 1
    end
    if t > 1 then
      t = t - 1
    end
    if t < 1 / 6 then
      return p + (q - p) * 6 * t
    end
    if t < 1 / 2 then
      return q
    end
    if t < 2 / 3 then
      return p + (q - p) * (2 / 3 - t) * 6
    end
    return p
  end
  local r, g, b
  if s == 0 then
    r, g, b = l, l, l
  else
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r, g, b = hue(p, q, h + 1 / 3), hue(p, q, h), hue(p, q, h - 1 / 3)
  end
  return string.format("#%02x%02x%02x", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end

--- Make a color a bit lighter and more vivid (used for bright terminal colors).
---@param color string
---@param lightness? number
---@param saturation? number
function M.brighten(color, lightness, saturation)
  local h, s, l = to_hsl(color)
  l = math.min(l + (lightness or 0.06), 1)
  s = math.min(s + (saturation or 0.1), 1)
  return from_hsl(h, s, l)
end

--- WCAG relative luminance
function M.luminance(hex)
  local c = rgb(hex)
  local function lin(v)
    v = v / 255
    return v <= 0.03928 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
  end
  return 0.2126 * lin(c[1]) + 0.7152 * lin(c[2]) + 0.0722 * lin(c[3])
end

--- WCAG contrast ratio between two colors
function M.contrast(a, b)
  local la, lb = M.luminance(a), M.luminance(b)
  if la < lb then
    la, lb = lb, la
  end
  return (la + 0.05) / (lb + 0.05)
end

---@param s any
function M.is_hex(s)
  return type(s) == "string" and s:match("^#%x%x%x%x%x%x$") ~= nil
end

--- Move `hex` toward `toward` until it has `ratio` contrast against `bg`.
function M.ensure_contrast(hex, bg, ratio, toward)
  if not (M.is_hex(hex) and M.is_hex(bg)) then
    return hex
  end
  local out = hex
  for i = 1, 20 do
    if M.contrast(out, bg) >= ratio then
      break
    end
    out = M.blend(toward, i * 0.05, hex)
  end
  return out
end

--- Blend `hex` toward `bg` until its contrast against `bg` drops to `ratio`.
--- Returns the input unchanged if it is already at or below `ratio`.
function M.reduce_contrast(hex, bg, ratio)
  if not (M.is_hex(hex) and M.is_hex(bg)) or M.contrast(hex, bg) <= ratio then
    return hex
  end
  local lo, hi = 0, 1 -- amount of `hex` kept
  for _ = 1, 24 do
    local mid = (lo + hi) / 2
    if M.contrast(M.blend(hex, mid, bg), bg) > ratio then
      hi = mid
    else
      lo = mid
    end
  end
  return M.blend(hex, hi, bg)
end

-- OKLab: a perceptual color space. L is lightness as the eye sees it, a/b
-- carry hue and chroma, so changing chroma here keeps perceived lightness
-- (HSL can't: an HSL-desaturated yellow looks darker, a blue lighter).

local function to_linear(v)
  v = v / 255
  return v <= 0.04045 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
end

local function from_linear(v)
  v = math.min(1, math.max(0, v))
  return 255 * (v <= 0.0031308 and 12.92 * v or 1.055 * v ^ (1 / 2.4) - 0.055)
end

local function cbrt(x)
  return x < 0 and -((-x) ^ (1 / 3)) or x ^ (1 / 3)
end

---@return number L, number a, number b
function M.to_oklab(hex)
  local c = rgb(hex)
  local r, g, b = to_linear(c[1]), to_linear(c[2]), to_linear(c[3])
  local l = cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b)
  local m = cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b)
  local s = cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b)
  return 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
    1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
    0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s
end

function M.from_oklab(L, a, b)
  local l = (L + 0.3963377774 * a + 0.2158037573 * b) ^ 3
  local m = (L - 0.1055613458 * a - 0.0638541728 * b) ^ 3
  local s = (L - 0.0894841775 * a - 1.2914855480 * b) ^ 3
  local function hex(v)
    return math.min(255, math.max(0, math.floor(from_linear(v) + 0.5)))
  end
  return string.format(
    "#%02x%02x%02x",
    hex(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s),
    hex(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s),
    hex(-0.0041960863 * l - 0.7034186147 * m + 1.7076127010 * s)
  )
end

--- Perceptual distance between two colors (OKLab, x100; ~3 is just noticeable).
function M.distance(a, b)
  local l1, a1, b1 = M.to_oklab(a)
  local l2, a2, b2 = M.to_oklab(b)
  return 100 * math.sqrt((l1 - l2) ^ 2 + (a1 - a2) ^ 2 + (b1 - b2) ^ 2)
end

--- Scale a color's chroma (0 = grey, 1 = unchanged), keeping its lightness.
function M.desaturate(hex, amount)
  if not M.is_hex(hex) or amount >= 1 then
    return hex
  end
  local L, a, b = M.to_oklab(hex)
  amount = math.max(0, amount)
  return M.from_oklab(L, a * amount, b * amount)
end

--- Adjust only the lightness of `hex` until its contrast against `bg` is
--- `ratio` (hue and chroma stay).
function M.match_contrast(hex, bg, ratio)
  if not (M.is_hex(hex) and M.is_hex(bg)) then
    return hex
  end
  local _, a, b = M.to_oklab(hex)
  local lighter = M.luminance(hex) >= M.luminance(bg)
  local lo, hi = 0, 1
  if lighter then
    lo = M.to_oklab(bg)
  else
    hi = M.to_oklab(bg)
  end
  for _ = 1, 20 do
    local mid = (lo + hi) / 2
    -- moving away from bg raises contrast
    if (M.contrast(M.from_oklab(mid, a, b), bg) < ratio) == lighter then
      lo = mid
    else
      hi = mid
    end
  end
  return M.from_oklab(lighter and hi or lo, a, b)
end

local me = debug.getinfo(1, "S").source:sub(2)
me = vim.fn.fnamemodify(me, ":h:h")

--- Load a module from this plugin without going through `require`'s search
--- path (faster and avoids picking up another copy of the plugin).
function M.mod(modname)
  if package.loaded[modname] then
    return package.loaded[modname]
  end
  local ret = loadfile(me .. "/" .. modname:gsub("%.", "/") .. ".lua")()
  package.loaded[modname] = ret
  return ret
end

--- Turn `style = {...}` into real attributes and apply the global
--- italics/bold switches.
---@param groups winteriscoming.Highlights
---@param opts winteriscoming.Config
function M.resolve(groups, opts)
  for _, hl in pairs(groups) do
    if type(hl) == "table" then
      if type(hl.style) == "table" then
        for k, v in pairs(hl.style) do
          hl[k] = v
        end
        hl.style = nil
      end
      if opts.italics == false then
        hl.italic = nil
      end
      if opts.bold == false then
        hl.bold = nil
      end
    end
  end
  return groups
end

--- Simple "${name}" interpolation used by the extras.
---@param str string
---@param tbl table
function M.template(str, tbl)
  return (
    str:gsub("($%b{})", function(w)
      return vim.tbl_get(tbl, unpack(vim.split(w:sub(3, -2), ".", { plain = true }))) or w
    end)
  )
end

function M.read(file)
  local fd = assert(io.open(file, "r"))
  local data = fd:read("*a")
  fd:close()
  return data
end

function M.write(file, contents)
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":h"), "p")
  local fd = assert(io.open(file, "w+"))
  fd:write(contents)
  fd:close()
end

M.cache = {}

function M.cache.file(key)
  return vim.fn.stdpath("cache") .. "/winteriscoming-" .. key .. ".json"
end

function M.cache.read(key)
  local ok, ret = pcall(function()
    return vim.json.decode(M.read(M.cache.file(key)), { luanil = { object = true, array = true } })
  end)
  return ok and ret or nil
end

function M.cache.write(key, data)
  pcall(M.write, M.cache.file(key), vim.json.encode(data))
end

function M.cache.clear()
  for _, style in ipairs({ "blue", "black", "light" }) do
    uv.fs_unlink(M.cache.file(style))
  end
end

return M
