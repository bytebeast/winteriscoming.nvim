local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  return Util.template(
    [[
# ${_style_name} for fzf. Source this file from your shell rc.
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:${bg_widget} \
  --color=bg:${bg_dark} \
  --color=border:${border_highlight} \
  --color=fg:${fg} \
  --color=gutter:${bg_dark} \
  --color=header:${cream} \
  --color=hl+:${ice} \
  --color=hl:${ice} \
  --color=info:${fg_muted} \
  --color=marker:${cream} \
  --color=pointer:${ice} \
  --color=prompt:${ice} \
  --color=query:${fg_light}:regular \
  --color=scrollbar:${border_highlight} \
  --color=separator:${cream} \
  --color=spinner:${purple} \
"
]],
    c
  )
end

return M
