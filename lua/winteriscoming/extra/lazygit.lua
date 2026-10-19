local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  return Util.template(
    [[
# ${_style_name} for lazygit: merge into ~/.config/lazygit/config.yml
gui:
  nerdFontsVersion: "3"
  theme:
    activeBorderColor:
      - "${blue}"
      - "bold"
    inactiveBorderColor:
      - "${border_highlight}"
    searchingActiveBorderColor:
      - "${cream}"
      - "bold"
    optionsTextColor:
      - "${sky}"
    selectedLineBgColor:
      - "${bg_visual}"
    cherryPickedCommitFgColor:
      - "${ice}"
    cherryPickedCommitBgColor:
      - "${bg_widget}"
    markedBaseCommitFgColor:
      - "${cream}"
    markedBaseCommitBgColor:
      - "${bg_widget}"
    unstagedChangesColor:
      - "${red}"
    defaultFgColor:
      - "${fg}"
]],
    c
  )
end

return M
