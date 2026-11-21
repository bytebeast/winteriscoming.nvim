-- Colorschemes for classic Vim, written as extras/vim/colors/winteriscoming-<style>.vim
-- so the folder works as a runtimepath entry. Built from the same highlight
-- groups Neovim gets; Vim has no treesitter or LSP semantic tokens, so the
-- @-groups are dropped and links into them are flattened. GUI colors only:
-- Vim needs `termguicolors` (or gVim).
local M = {}

-- Vim 8 knows these; the newer underline styles fall back to `underline`
-- stylua: ignore
local attrs = {
  bold = "bold", italic = "italic", underline = "underline", undercurl = "undercurl",
  underdouble = "underline", underdotted = "underline", underdashed = "underline",
  strikethrough = "strikethrough", reverse = "reverse", standout = "standout", nocombine = "nocombine",
}

local function valid(name)
  return name:match("^[%w_]+$") ~= nil
end

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local opts = require("winteriscoming.config").extend({ style = c.style, cache = false })
  local groups = require("winteriscoming.groups").setup(c, opts, {})
  for name, def in pairs(groups) do
    if type(def) == "string" then
      groups[name] = { link = def }
    end
  end

  -- follow links until a group with colors (or a name Vim may define itself)
  local function concrete(name)
    local seen = {}
    while groups[name] and groups[name].link and not seen[name] do
      seen[name] = true
      name = groups[name].link
    end
    return name
  end

  local function hi(name, def)
    local parts = { "hi " .. name }
    for _, k in ipairs({ "fg", "bg", "sp" }) do
      if def[k] then
        parts[#parts + 1] = ("gui%s=%s"):format(k, def[k])
      end
    end
    local words, seen = {}, {}
    for key, word in pairs(attrs) do
      if def[key] and not seen[word] then
        seen[word] = true
        words[#words + 1] = word
      end
    end
    table.sort(words)
    parts[#parts + 1] = "gui=" .. (#words > 0 and table.concat(words, ",") or "NONE")
    parts[#parts + 1] = "cterm=NONE"
    return table.concat(parts, " ")
  end

  local names = vim.tbl_filter(valid, vim.tbl_keys(groups))
  table.sort(names)
  local out = {
    ('" %s for Vim (8.2+ with termguicolors, or gVim)'):format(c._style_name),
    '" upstream: ' .. c._upstream_url,
    '" Add extras/vim to your runtimepath, then :colorscheme ' .. c._name:gsub("_", "-"),
    "set background=" .. (c.is_light and "light" or "dark"),
    "hi clear",
    'if exists("syntax_on") | syntax reset | endif',
    ('let g:colors_name = "winteriscoming-%s"'):format(c.style),
    "",
  }
  for _, name in ipairs(names) do
    local def = groups[name]
    if def.link then
      local target = valid(def.link) and def.link or concrete(def.link)
      if valid(target) then
        out[#out + 1] = ("hi! link %s %s"):format(name, target)
      elseif groups[target] then
        out[#out + 1] = hi(name, groups[target])
      end
    elseif next(def) then
      out[#out + 1] = hi(name, def)
    end
  end
  local ansi = vim.tbl_map(function(color)
    return '"' .. color .. '"'
  end, require("winteriscoming.extra").ansi(c))
  out[#out + 1] = ""
  out[#out + 1] = "let g:terminal_ansi_colors = [" .. table.concat(ansi, ", ") .. "]"
  return table.concat(out, "\n") .. "\n"
end

function M.static()
  local files = {}
  for _, style in ipairs(require("winteriscoming.config").styles) do
    files["colors/winteriscoming-" .. style .. ".vim"] = require("winteriscoming.extra").render("vim", style)
  end
  return files
end

return M
