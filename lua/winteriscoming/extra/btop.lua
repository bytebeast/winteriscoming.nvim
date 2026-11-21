-- btop theme. Keys are btop's Default_theme (src/btop_theme.cpp). Meters
-- that mean strain (temperature, CPU, memory used, processes) run green ->
-- amber -> red; throughput and free memory use cool hues so the two kinds
-- don't read alike.
local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  -- stylua: ignore
  local keys = {
    { "main_bg", c.bg }, { "main_fg", c.fg }, { "title", c.fg_light }, { "hi_fg", c.ice },
    { "selected_bg", c.bg_widget }, { "selected_fg", c.fg_bright }, { "inactive_fg", c.fg_muted },
    { "graph_text", c.fg_dark }, { "meter_bg", c.bg_widget }, { "proc_misc", c.teal },
    { "cpu_box", c.blue }, { "mem_box", c.green }, { "net_box", c.purple }, { "proc_box", c.ember },
    { "div_line", c.border },
    { "temp_start", c.green }, { "temp_mid", c.amber }, { "temp_end", c.red },
    { "cpu_start", c.green }, { "cpu_mid", c.amber }, { "cpu_end", c.red },
    { "free_start", c.teal }, { "free_mid", c.sky }, { "free_end", c.blue },
    { "cached_start", c.azure }, { "cached_mid", c.blue }, { "cached_end", c.purple },
    { "available_start", c.teal }, { "available_mid", c.green }, { "available_end", c.green },
    { "used_start", c.green }, { "used_mid", c.amber }, { "used_end", c.red },
    { "download_start", c.sky }, { "download_mid", c.blue }, { "download_end", c.lavender },
    { "upload_start", c.teal }, { "upload_mid", c.green }, { "upload_end", c.cream },
    { "process_start", c.green }, { "process_mid", c.amber }, { "process_end", c.red },
    { "proc_pause_bg", c.error }, { "proc_follow_bg", c.blue },
    { "proc_banner_bg", c.bg_widget }, { "proc_banner_fg", c.fg_light },
    { "followed_bg", c.blue }, { "followed_fg", c.on_accent },
  }
  local out = {
    ("# %s for btop: copy to ~/.config/btop/themes/, then pick it in the options menu (o)"):format(c._style_name),
    "# upstream: " .. c._upstream_url,
  }
  for _, kv in ipairs(keys) do
    out[#out + 1] = ('theme[%s]="%s"'):format(kv[1], kv[2])
  end
  return table.concat(out, "\n") .. "\n"
end

return M
