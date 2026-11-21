local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/ibhagwan/fzf-lua"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    FzfLuaNormal        = { fg = c.fg, bg = c.bg_float },
    FzfLuaBorder        = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaTitle         = { fg = c.prompt, bg = c.bg_float },
    FzfLuaPreviewTitle  = { fg = c.accent, bg = c.bg_float },
    FzfLuaCursor        = "IncSearch",
    FzfLuaCursorLine    = { bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.22) },
    FzfLuaDirPart       = { fg = c.fg_muted },
    FzfLuaFilePart      = "FzfLuaFzfNormal",
    FzfLuaFzfNormal     = { fg = c.fg },
    FzfLuaFzfCursorLine = { fg = c.fg_bright, bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.22) },
    FzfLuaFzfMatch      = { fg = c.ice, bold = true },
    FzfLuaFzfPointer    = { fg = c.ice },
    FzfLuaFzfPrompt     = { fg = c.ice },
    FzfLuaFzfSeparator  = { fg = c.prompt, bg = c.bg_float },
    FzfLuaFzfInfo       = { fg = c.fg_muted },
    FzfLuaHeaderBind    = { fg = c.cream },
    FzfLuaHeaderText    = { fg = c.blue },
    FzfLuaPath          = "Directory",
    FzfLuaBufFlagCur    = { fg = c.cream },
    FzfLuaTabMarker     = { fg = c.cream },
  }
  if opts.borderless then
    local p = c.picker
    ret.FzfLuaNormal = { fg = c.fg, bg = p.list }
    ret.FzfLuaBorder = { fg = p.list, bg = p.list }
    ret.FzfLuaTitle = { fg = c.on_accent, bg = c.prompt, bold = true }
    ret.FzfLuaPreviewNormal = { fg = c.fg, bg = p.preview }
    ret.FzfLuaPreviewBorder = { fg = p.preview, bg = p.preview }
    ret.FzfLuaPreviewTitle = { fg = c.on_accent, bg = c.accent, bold = true }
    ret.FzfLuaFzfGutter = { bg = p.list }
    ret.FzfLuaFzfBorder = { fg = p.list }
    ret.FzfLuaFzfSeparator = { fg = p.list, bg = p.list }
    ret.FzfLuaCursorLine = { bg = p.sel }
    ret.FzfLuaFzfCursorLine = { fg = c.fg_bright, bg = p.sel }
  end
  return ret
end

return M
