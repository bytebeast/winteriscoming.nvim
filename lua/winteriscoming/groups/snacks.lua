local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/folke/snacks.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local bg = opts.transparent and c.none or c.bg
  -- stylua: ignore
  local ret = {
    -- Notifier
    SnacksNotifierDebug       = { fg = c.fg, bg = bg },
    SnacksNotifierBorderDebug = { fg = Util.blend_bg(c.fg_muted, 0.6), bg = bg },
    SnacksNotifierIconDebug   = { fg = c.fg_muted },
    SnacksNotifierTitleDebug  = { fg = c.fg_muted },
    SnacksNotifierError       = { fg = c.fg, bg = bg },
    SnacksNotifierBorderError = { fg = Util.blend_bg(c.error, 0.5), bg = bg },
    SnacksNotifierIconError   = { fg = c.error },
    SnacksNotifierTitleError  = { fg = c.error },
    SnacksNotifierInfo        = { fg = c.fg, bg = bg },
    SnacksNotifierBorderInfo  = { fg = Util.blend_bg(c.info, 0.5), bg = bg },
    SnacksNotifierIconInfo    = { fg = c.info },
    SnacksNotifierTitleInfo   = { fg = c.info },
    SnacksNotifierTrace       = { fg = c.fg, bg = bg },
    SnacksNotifierBorderTrace = { fg = Util.blend_bg(c.purple, 0.5), bg = bg },
    SnacksNotifierIconTrace   = { fg = c.purple },
    SnacksNotifierTitleTrace  = { fg = c.purple },
    SnacksNotifierWarn        = { fg = c.fg, bg = bg },
    SnacksNotifierBorderWarn  = { fg = Util.blend_bg(c.warning, 0.5), bg = bg },
    SnacksNotifierIconWarn    = { fg = c.warning },
    SnacksNotifierTitleWarn   = { fg = c.warning },
    -- Dashboard
    SnacksDashboardHeader     = { fg = c.ice },
    SnacksDashboardDesc       = { fg = c.fg_light },
    SnacksDashboardIcon       = { fg = c.sky },
    SnacksDashboardKey        = { fg = c.cream },
    SnacksDashboardFooter     = { fg = c.jade, italic = true },
    SnacksDashboardSpecial    = { fg = c.purple },
    SnacksDashboardDir        = { fg = c.fg_muted },
    SnacksDashboardFile       = { fg = c.fg_light },
    SnacksDashboardTitle      = { fg = c.blue, bold = true },
    -- Profiler / footer badges
    SnacksProfilerIconInfo    = { fg = c.ice, bg = Util.blend_bg(c.ice, 0.25) },
    SnacksProfilerBadgeInfo   = { fg = c.ice, bg = Util.blend_bg(c.ice, 0.1) },
    SnacksProfilerIconTrace   = { fg = c.fg_muted, bg = Util.blend_bg(c.fg_muted, 0.25) },
    SnacksProfilerBadgeTrace  = { fg = c.fg_muted, bg = Util.blend_bg(c.fg_muted, 0.1) },
    SnacksFooterKey           = "SnacksProfilerIconInfo",
    SnacksFooterDesc          = "SnacksProfilerBadgeInfo",
    -- Indent: guides from editorIndentGuide, scope from the purple active guide
    SnacksIndent              = { fg = c.fg_gutter, nocombine = true },
    SnacksIndentScope         = { fg = c.indent_scope, nocombine = true },
    SnacksIndentChunk         = { fg = c.indent_scope, nocombine = true },
    -- Misc
    SnacksZenIcon             = { fg = c.purple },
    SnacksInputIcon           = { fg = c.ice },
    SnacksInputBorder         = { fg = c.prompt, bg = c.bg_float },
    SnacksInputTitle          = { fg = c.prompt, bg = c.bg_float },
    SnacksBackdrop            = { bg = c.black },
    SnacksScratchKey          = "SnacksProfilerIconInfo",
    SnacksScratchDesc         = "SnacksProfilerBadgeInfo",
    -- Image
    SnacksImageSpinner        = { fg = c.ice },
    SnacksImageAnchor         = { fg = c.sky },
    SnacksImageLoading        = { fg = c.fg_muted },
    SnacksImageMath           = { fg = c.syntax.constant },
    -- Picker
    SnacksPickerInputBorder   = { fg = c.prompt, bg = c.bg_float },
    SnacksPickerInputTitle    = { fg = c.prompt, bg = c.bg_float },
    SnacksPickerBoxTitle      = { fg = c.prompt, bg = c.bg_float },
    SnacksPickerTitle         = { fg = c.blue, bg = c.bg_float, bold = true },
    SnacksPickerPrompt        = { fg = c.ice },
    SnacksPickerMatch         = { fg = c.ice, bold = true },
    SnacksPickerSelected      = { fg = c.cream },
    SnacksPickerCursorLine    = { bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.22) },
    SnacksPickerListCursorLine= "SnacksPickerCursorLine",
    SnacksPickerDir           = { fg = c.fg_muted },
    SnacksPickerPathHidden    = { fg = c.fg_muted },
    SnacksPickerToggle        = "SnacksProfilerBadgeInfo",
    SnacksPickerPickWinCurrent= { fg = c.on_accent, bg = c.label, bold = true },
    SnacksPickerPickWin       = { fg = c.fg_bright, bg = c.bg_search, bold = true },
    SnacksPickerGitStatusUntracked = { fg = c.git.untracked },
    SnacksGhLabel             = { fg = c.ice, bold = true },
    SnacksDiffLabel           = { fg = c.ice, bold = true },
    SnacksGhDiffHeader        = { fg = c.ice, bg = Util.blend_bg(c.ice, 0.1) },
  }
  for i, color in ipairs(c.rainbow) do
    ret["SnacksIndent" .. i] = { fg = color, nocombine = true }
  end
  return ret
end

return M
