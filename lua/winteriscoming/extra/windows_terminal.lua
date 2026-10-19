local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local t = c.terminal
  local scheme = {
    name = c._style_name,
    background = c.bg,
    foreground = t.white,
    cursorColor = c.blue,
    selectionBackground = c.bg_visual,
    black = t.black,
    red = t.red,
    green = t.green,
    yellow = t.yellow,
    blue = t.blue,
    purple = t.magenta,
    cyan = t.cyan,
    white = t.white,
    brightBlack = t.black_bright,
    brightRed = t.red_bright,
    brightGreen = t.green_bright,
    brightYellow = t.yellow_bright,
    brightBlue = t.blue_bright,
    brightPurple = t.magenta_bright,
    brightCyan = t.cyan_bright,
    brightWhite = t.white_bright,
  }
  -- stable key order for readable diffs
  local keys = vim.tbl_keys(scheme)
  table.sort(keys)
  local lines = {}
  for _, k in ipairs(keys) do
    lines[#lines + 1] = string.format('  "%s": "%s"', k, scheme[k])
  end
  return "{\n" .. table.concat(lines, ",\n") .. "\n}\n"
end

return M
