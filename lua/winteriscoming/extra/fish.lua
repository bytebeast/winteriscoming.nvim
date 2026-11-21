-- fish theme file for `fish_config theme choose` (fish 3.4+). Keys are the
-- documented fish_color_* and fish_pager_color_* variables
-- (doc_src/interactive.rst); no [light]/[dark] sections, so older fish reads
-- it too. Colors are RRGGBB without "#".
local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local s = c.syntax
  local function hex(color)
    return (color:gsub("^#", ""))
  end
  local function bg(color)
    return "--background=" .. hex(color)
  end
  local comment = hex(s.comment) .. ((c._styles.comments or {}).italic and " --italics" or "")
  -- stylua: ignore
  local vars = {
    { "fish_color_normal", hex(c.fg) },
    { "fish_color_command", hex(s.func) },
    { "fish_color_builtin", hex(s.func_builtin) },
    { "fish_color_function", hex(s.func) },
    { "fish_color_keyword", hex(s.keyword) },
    { "fish_color_param", hex(s.param) },
    { "fish_color_option", hex(s.attribute) },
    { "fish_color_quote", hex(s.string) },
    { "fish_color_escape", hex(s.escape) },
    { "fish_color_redirection", hex(s.operator) },
    { "fish_color_operator", hex(s.operator) },
    { "fish_color_end", hex(s.storage) },
    { "fish_color_comment", comment },
    { "fish_color_error", hex(c.error) },
    { "fish_color_valid_path", "--underline" },
    { "fish_color_autosuggestion", hex(c.dark5) },
    { "fish_color_selection", bg(c.bg_visual) },
    { "fish_color_search_match", bg(c.bg_search) },
    { "fish_color_history_current", hex(c.teal) .. " --bold" },
    { "fish_color_cancel", hex(c.error) },
    { "fish_color_cwd", hex(c.sky) },
    { "fish_color_cwd_root", hex(c.error) },
    { "fish_color_user", hex(c.green) },
    { "fish_color_host", hex(c.blue) },
    { "fish_color_host_remote", hex(c.cream) },
    { "fish_color_status", hex(c.error) },
    { "fish_pager_color_progress", hex(c.fg_muted) },
    { "fish_pager_color_prefix", hex(c.ice) .. " --bold" },
    { "fish_pager_color_completion", hex(c.fg) },
    { "fish_pager_color_description", hex(c.fg_muted) },
    { "fish_pager_color_selected_background", bg(c.bg_widget) },
  }
  local out = {
    ("# name: '%s'"):format(c._style_name),
    ("# url: '%s'"):format(c._upstream_url),
    "# preferred_background: " .. hex(c.bg),
    "# Copy to ~/.config/fish/themes/, then: fish_config theme choose " .. c._name,
    "",
  }
  for _, v in ipairs(vars) do
    out[#out + 1] = v[1] .. " " .. v[2]
  end
  return table.concat(out, "\n") .. "\n"
end

return M
