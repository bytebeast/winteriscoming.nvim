local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  return Util.template(
    [[
# ${_style_name} for git-delta.
# 1. Install the bat theme from extras/bat (delta uses bat's themes).
# 2. Add to ~/.gitconfig:
#      [include]
#          path = /path/to/this/file
#      [delta]
#          features = ${_name}

[delta "${_name}"]
    syntax-theme = ${_name}
    dark = ${_dark}
    minus-style = syntax "${diff.delete}"
    minus-non-emph-style = syntax "${diff.delete}"
    minus-emph-style = syntax "${_minus_emph}"
    plus-style = syntax "${diff.add}"
    plus-non-emph-style = syntax "${diff.add}"
    plus-emph-style = syntax "${_plus_emph}"
    line-numbers-minus-style = "${git.delete}"
    line-numbers-plus-style = "${git.add}"
    line-numbers-zero-style = "${line_nr}"
    line-numbers-left-style = "${border_highlight}"
    line-numbers-right-style = "${border_highlight}"
    file-style = "${blue}" bold
    file-decoration-style = "${border_highlight}" ul
    hunk-header-style = file line-number syntax
    hunk-header-decoration-style = "${border_highlight}" box
    hunk-header-line-number-style = "${cream}"
    hunk-header-file-style = "${sky}"
    commit-decoration-style = "${blue}" box
    blame-palette = "${bg} ${bg_dark} ${bg_widget}"
]],
    vim.tbl_extend("force", c, {
      _dark = c.is_light and "false" or "true",
      _minus_emph = Util.blend(c.red, 0.38, c.bg),
      _plus_emph = Util.blend(c.git.add, 0.32, c.bg),
    })
  )
end

return M
