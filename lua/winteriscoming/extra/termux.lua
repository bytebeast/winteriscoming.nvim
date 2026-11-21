-- Termux: save as ~/.termux/colors.properties, then `termux-reload-settings`.
-- Keys from termux-app TerminalColorScheme.updateWith(); anything else is
-- rejected.
local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local out = {
    ("# %s for Termux: save as ~/.termux/colors.properties, then termux-reload-settings"):format(c._style_name),
    "# upstream: " .. c._upstream_url,
    "foreground=" .. c.terminal.white,
    "background=" .. c.bg,
    "cursor=" .. c.blue,
  }
  for i, color in ipairs(require("winteriscoming.extra").ansi(c)) do
    out[#out + 1] = ("color%d=%s"):format(i - 1, color)
  end
  return table.concat(out, "\n") .. "\n"
end

return M
