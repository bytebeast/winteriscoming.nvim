local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/nvim-telescope/telescope.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    TelescopeNormal         = { fg = c.fg, bg = c.bg_float },
    TelescopeBorder         = { fg = c.border_highlight, bg = c.bg_float },
    TelescopeTitle          = { fg = c.accent, bg = c.bg_float, bold = true },
    TelescopePromptNormal   = { fg = c.fg_light, bg = c.bg_float },
    TelescopePromptBorder   = { fg = c.prompt, bg = c.bg_float },
    TelescopePromptTitle    = { fg = c.prompt, bg = c.bg_float },
    TelescopePromptPrefix   = { fg = c.ice, bg = c.bg_float },
    TelescopeSelection      = { bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.22) },
    TelescopeSelectionCaret = { fg = c.ice },
    TelescopeMultiSelection = { fg = c.cream },
    TelescopeMatching       = { fg = c.ice, bold = true },
    TelescopeResultsComment = { fg = c.fg_muted },
  }
  if opts.borderless then
    local p = c.picker
    local function panel(bg)
      return { fg = c.fg, bg = bg }, { fg = bg, bg = bg }
    end
    ret.TelescopeNormal, ret.TelescopeBorder = panel(p.list)
    ret.TelescopePromptNormal, ret.TelescopePromptBorder = panel(p.prompt)
    ret.TelescopeResultsNormal, ret.TelescopeResultsBorder = panel(p.list)
    ret.TelescopePreviewNormal, ret.TelescopePreviewBorder = panel(p.preview)
    ret.TelescopePromptPrefix = { fg = c.ice, bg = p.prompt }
    ret.TelescopePromptCounter = { fg = c.fg_muted, bg = p.prompt }
    -- without lines, titles become badges
    ret.TelescopeTitle = { fg = c.on_accent, bg = c.accent, bold = true }
    ret.TelescopePromptTitle = { fg = c.on_accent, bg = c.prompt, bold = true }
    ret.TelescopeResultsTitle = "TelescopeTitle"
    ret.TelescopePreviewTitle = "TelescopeTitle"
    ret.TelescopeSelection = { bg = p.sel, bold = true }
    ret.TelescopeSelectionCaret = { fg = c.ice, bg = p.sel }
  end
  return ret
end

return M
