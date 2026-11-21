local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/akinsho/git-conflict.nvim"

-- "ours" (current) takes the git add hue, "theirs" (incoming) the conflict
-- orange, and the common ancestor (diff3) stays neutral. Labels (the
-- <<<<<<< / >>>>>>> lines) are a step deeper.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local alpha = 0.17
  local function side(name, color)
    return {
      ["GitConflict" .. name] = { bg = Util.blend_bg(color, alpha) },
      ["GitConflict" .. name .. "Label"] = { fg = c.fg, bg = Util.blend_bg(color, alpha * 2), bold = true },
    }
  end
  return vim.tbl_extend("force", side("Current", c.git.add), side("Incoming", c.git.conflict), {
    GitConflictAncestor = { bg = c.bg_widget },
    GitConflictAncestorLabel = { fg = c.fg, bg = c.bg_widget, bold = true },
  })
end

return M
