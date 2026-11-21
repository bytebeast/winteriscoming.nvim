local M = {}

M.url = "https://github.com/m-demare/hlargs.nvim"

-- Arguments keep the parameter color through the whole function body.
-- hlargs only sets `Hlargs` itself when its `color` option is left alone.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    Hlargs                 = { fg = c.syntax.param, style = opts.styles.parameters },
    HlargsUnused           = { fg = c.fg_muted },
    ["@HlargsNamedParams"] = { fg = c.syntax.param, style = opts.styles.parameters },
  }
  return ret
end

return M
