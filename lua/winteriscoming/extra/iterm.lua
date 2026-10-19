local Util = require("winteriscoming.util")

local M = {}

local function entry(name, hex)
  local rgb = Util.rgb(hex)
  return string.format(
    [[
	<key>%s</key>
	<dict>
		<key>Alpha Component</key>
		<real>1</real>
		<key>Blue Component</key>
		<real>%.6f</real>
		<key>Color Space</key>
		<string>sRGB</string>
		<key>Green Component</key>
		<real>%.6f</real>
		<key>Red Component</key>
		<real>%.6f</real>
	</dict>]],
    name,
    rgb[3] / 255,
    rgb[2] / 255,
    rgb[1] / 255
  )
end

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local t = c.terminal
  local order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  local out = {
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
    '<plist version="1.0">',
    "<dict>",
  }
  for i, name in ipairs(order) do
    out[#out + 1] = entry("Ansi " .. (i - 1) .. " Color", t[name])
    out[#out + 1] = entry("Ansi " .. (i + 7) .. " Color", t[name .. "_bright"])
  end
  out[#out + 1] = entry("Background Color", c.bg)
  out[#out + 1] = entry("Foreground Color", t.white)
  out[#out + 1] = entry("Bold Color", c.fg_bright)
  out[#out + 1] = entry("Cursor Color", c.blue)
  out[#out + 1] = entry("Cursor Text Color", c.bg)
  out[#out + 1] = entry("Selection Color", c.bg_visual)
  out[#out + 1] = entry("Selected Text Color", c.fg_bright)
  out[#out + 1] = entry("Link Color", c.aqua)
  out[#out + 1] = entry("Badge Color", c.blue)
  out[#out + 1] = "</dict>"
  out[#out + 1] = "</plist>"
  return table.concat(out, "\n") .. "\n"
end

return M
