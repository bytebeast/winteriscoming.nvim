local M = {}

function M.check()
  local h = vim.health
  h.start("winteriscoming.nvim")

  local v = vim.version()
  h.ok(("Neovim %d.%d.%d"):format(v.major, v.minor, v.patch))

  if vim.o.termguicolors then
    h.ok("'termguicolors' is on")
  else
    h.warn("'termguicolors' is off (it is enabled when the theme loads)")
  end

  local name = vim.g.colors_name or ""
  if name:find("^winteriscoming") then
    h.ok("Active: " .. name .. " (background=" .. vim.o.background .. ")")
  else
    h.info("winteriscoming is not the active colorscheme (current: " .. (name ~= "" and name or "none") .. ")")
  end

  local Config = require("winteriscoming.config")
  local Groups = require("winteriscoming.groups")
  local opts = Config.extend({ style = name:match("^winteriscoming%-(%a+)$") })
  if Groups.installed() then
    h.ok("Plugin manager detected (lazy.nvim / vim.pack): integrations are auto-enabled")
  else
    h.info("No supported plugin manager detected: all integrations are enabled")
  end
  local enabled = vim.tbl_keys(Groups.enabled(opts))
  table.sort(enabled)
  h.info(("%d integrations enabled: %s"):format(#enabled, table.concat(enabled, ", ")))

  local ok, colors = pcall(require("winteriscoming.colors").setup, opts)
  if not ok then
    h.error("Building colors failed: " .. tostring(colors))
    return
  end
  local Util = require("winteriscoming.util")
  local bad = {}
  for role, value in pairs(colors.syntax) do
    if type(value) ~= "string" or not value:match("^#%x%x%x%x%x%x$") then
      bad[#bad + 1] = "syntax." .. role .. "=" .. tostring(value)
    end
  end
  if #bad > 0 then
    table.sort(bad)
    h.warn("Non-hex syntax roles (check on_colors): " .. table.concat(bad, ", "))
    return
  end
  h.ok("All syntax roles are valid colors")

  -- The stock palette keeps some roles below 4.5:1 on purpose (they follow
  -- the VS Code theme), so only report what `on_colors` made worse.
  local stock = require("winteriscoming.colors").setup(vim.tbl_extend("force", opts, { on_colors = function() end }))
  local low = {}
  for role, value in pairs(colors.syntax) do
    local ratio = Util.contrast(value, colors.bg)
    if ratio < 4.5 and ratio < Util.contrast(stock.syntax[role], stock.bg) - 0.05 then
      low[#low + 1] = ("%s %.1f:1"):format(role, ratio)
    end
  end
  if #low > 0 then
    table.sort(low)
    h.warn("on_colors pushed these syntax roles below WCAG AA (4.5:1): " .. table.concat(low, ", "))
  else
    h.ok("on_colors did not lower any syntax role below WCAG AA")
  end

  -- non-default options, so a report shows what's shaping the colors
  local active = {}
  for _, key in ipairs({
    "contrast",
    "subtle_comments",
    "colorblind",
    "saturation",
    "accent",
    "rainbow",
    "rainbow_variables",
    "borderless",
    "bright_borders",
    "inlay_hints",
    "hide_inactive_statusline",
  }) do
    if opts[key] ~= Config.defaults[key] then
      active[#active + 1] = ("%s = %s"):format(key, vim.inspect(opts[key]))
    end
  end
  for _, key in ipairs({ "underline", "virtual_text" }) do
    if opts.diagnostics[key] ~= Config.defaults.diagnostics[key] then
      active[#active + 1] = ("diagnostics.%s = %s"):format(key, vim.inspect(opts.diagnostics[key]))
    end
  end
  if #active > 0 then
    h.info("Options: " .. table.concat(active, ", "))
  end
  if opts.rainbow_variables then
    local count = require("winteriscoming.semantic").count
    if count > 0 then
      h.ok(("rainbow_variables: %d colors, applied to LSP semantic tokens"):format(count))
    else
      h.warn("rainbow_variables is on but not active (load the colorscheme with an LSP that sends semantic tokens)")
    end
  end
end

return M
