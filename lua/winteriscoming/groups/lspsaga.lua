local M = {}

M.url = "https://github.com/nvimdev/lspsaga.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    SagaNormal       = "NormalFloat",
    SagaBorder       = "FloatBorder",
    SagaTitle        = "FloatTitle",
    SagaBeacon       = { bg = c.label },
    SagaWinbarSep    = { fg = c.fg_muted },
    SagaWinbarFileName = { fg = c.fg_dark },
    SagaLightBulb    = { fg = c.cream },
    SagaCount        = { fg = c.purple },
    SagaFinderFname  = { fg = c.sky },
    ActionPreviewTitle = { fg = c.blue },
  }
  return ret
end

return M
