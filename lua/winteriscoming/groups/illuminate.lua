local M = {}

M.url = "https://github.com/RRethy/vim-illuminate"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    IlluminatedWordRead  = { bg = c.bg_visual },
    IlluminatedWordText  = { bg = c.bg_visual },
    IlluminatedWordWrite = { bg = c.bg_visual, underline = true, sp = c.blue },
    illuminatedCurWord   = { bg = c.bg_visual },
    illuminatedWord      = { bg = c.bg_visual },
  }
  return ret
end

return M
