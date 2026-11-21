-- X resources for xterm, URxvt and other X terminals.
local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local out = {
    ("! %s for X terminals: xrdb -merge this file, or #include it in ~/.Xresources"):format(c._style_name),
    "! upstream: " .. c._upstream_url,
    "",
    "*.foreground: " .. c.terminal.white,
    "*.background: " .. c.bg,
    "*.cursorColor: " .. c.blue,
  }
  for i, color in ipairs(require("winteriscoming.extra").ansi(c)) do
    out[#out + 1] = ("*.color%d: %s"):format(i - 1, color)
  end
  return table.concat(out, "\n") .. "\n"
end

return M
