local M = {}

M.url = "https://github.com/xiyaowong/nvim-cursorword"

-- Same look as LSP references, so every word-under-cursor plugin agrees.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  return {
    CursorWord = "LspReferenceText",
  }
end

return M
