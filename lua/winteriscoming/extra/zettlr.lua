-- Zettlr theme as Custom CSS (https://docs.zettlr.com/en/guides/custom-css.html).
-- Uses Zettlr's documented editor variables (--zettlr-editor-*) plus the
-- CodeMirror classes Zettlr assigns for syntax highlighting. Selectors are
-- prefixed with `html body` so they outrank Zettlr's built-in rules.
--
-- Each file applies in one Zettlr mode only: light when dark mode is off,
-- the dark styles when it's on. Concatenate a light and a dark file to get a
-- theme that follows Zettlr's dark-mode toggle.
local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local t = vim.deepcopy(c)
  t._mode = c.is_light and "html body:not(.dark)" or "html body.dark"
  -- extra id-level specificity for Zettlr's chrome, whose own rules carry Vue
  -- scoped attributes and per-platform classes
  t._boost = t._mode .. ":not(#winteriscoming)"
  t._mode_name = c.is_light and "light mode (dark mode off)" or "dark mode"
  t._cite_bg = Util.blend_bg(c.ember, 0.12)
  t._tag_bg = Util.blend_bg(c.sky, 0.12)
  t._sel = Util.blend_bg(c.blue, c.is_light and 0.2 or 0.3) -- PmenuSel
  t._comment_style = (c._styles and c._styles.comments and c._styles.comments.italic) and "italic" or "normal"
  t._keyword_style = (c._styles and c._styles.keywords and c._styles.keywords.italic) and "italic" or "normal"
  for i = 1, 6 do
    t["_h" .. i] = c.rainbow[i]
  end
  return Util.template(
    [[
/*
 * ${_style_name} for Zettlr (applies in ${_mode_name})
 * upstream: ${_upstream_url}
 *
 * Install: Zettlr -> Assets Manager -> Custom CSS, paste this file, save.
 * To follow Zettlr's dark mode, paste a light and a dark file together, e.g.
 *   cat winteriscoming_light.css winteriscoming_blue.css
 * Themes the editor, file manager, sidebar, menu bar, toolbar, tabs and
 * status bar.
 */

/* ── Editor colors (Zettlr's documented variables) ─────────────────────── */
${_mode} .cm-editor {
  --zettlr-editor-scroller-color: ${fg};
  --zettlr-editor-scroller-bg: ${bg};
  --zettlr-editor-primary-color: ${accent};
  --zettlr-editor-secondary-color: ${syntax.md_link_text};
  --zettlr-editor-selection-color: ${bg_visual};
  --zettlr-editor-highlight-color: ${bg_search};
  --zettlr-editor-code-color: ${syntax.md_code};
  --zettlr-editor-code-bg: ${bg_highlight};
  --zettlr-editor-citation-color: ${ember};
  --zettlr-editor-citation-bg: ${_cite_bg};
  --zettlr-editor-escape-color: ${pink};
  --zettlr-editor-accent-color: ${on_accent};
  --zettlr-editor-accent-bg: ${lavender};
  --zettlr-editor-error-color: ${red};
}

/* Zettlr's accent (selected files, toggles, focus) normally follows your OS
   accent color. Delete these two lines to keep that behavior. */
${_mode} { --system-accent-color: ${accent}; --system-accent-color-contrast: ${on_accent}; }

${_mode} .main-editor-wrapper { background-color: ${bg}; }
${_mode} .cm-editor .cm-gutters { background-color: ${bg}; color: ${line_nr}; border-right-color: ${bg_highlight}; }
${_mode} .cm-editor .cm-activeLineGutter { color: ${line_nr_cursor}; }
${_mode} .cm-editor .code-block-line-background { background-color: ${bg_dark}; }
${_mode} .cm-editor .inline-code-background { background-color: ${bg_highlight}; }
${_mode} .cm-editor .cm-quote { color: ${syntax.md_quote}; }
${_mode} .cm-editor .cm-code-mark { color: ${fg_muted}; }
${_mode} .cm-editor .cm-zkn-tag { color: ${sky}; background-color: ${_tag_bg}; border-radius: 3px; }
${_mode} .cm-editor .cm-zkn-link { color: ${syntax.md_link}; }

/* Headings: same colors as the markdown headings in Neovim */
${_mode} .cm-editor .cm-header-1 { color: ${_h1}; }
${_mode} .cm-editor .cm-header-2 { color: ${_h2}; }
${_mode} .cm-editor .cm-header-3 { color: ${_h3}; }
${_mode} .cm-editor .cm-header-4 { color: ${_h4}; }
${_mode} .cm-editor .cm-header-5 { color: ${_h5}; }
${_mode} .cm-editor .cm-header-6 { color: ${_h6}; }

/* ── Code block syntax highlighting (same roles as in Neovim) ────────────── */
${_mode} .cm-editor .cm-comment,
${_mode} .cm-editor .cm-line-comment,
${_mode} .cm-editor .cm-block-comment { color: ${syntax.comment}; font-style: ${_comment_style}; }
${_mode} .cm-editor .cm-doc-comment,
${_mode} .cm-editor .cm-doc-string { color: ${syntax.docstring}; font-style: ${_comment_style}; }
${_mode} .cm-editor .cm-keyword,
${_mode} .cm-editor .cm-control-keyword,
${_mode} .cm-editor .cm-definition-keyword,
${_mode} .cm-editor .cm-operator-keyword,
${_mode} .cm-editor .cm-modifier { color: ${syntax.keyword}; font-style: ${_keyword_style}; }
${_mode} .cm-editor .cm-module-keyword { color: ${syntax.keyword}; font-style: ${_keyword_style}; }
${_mode} .cm-editor .cm-string { color: ${syntax.string}; }
${_mode} .cm-editor .cm-character { color: ${syntax.string}; }
${_mode} .cm-editor .cm-escape { color: ${syntax.escape}; }
${_mode} .cm-editor .cm-regexp { color: ${syntax.regexp}; }
${_mode} .cm-editor .cm-number,
${_mode} .cm-editor .cm-integer,
${_mode} .cm-editor .cm-float,
${_mode} .cm-editor .cm-unit { color: ${syntax.number}; }
${_mode} .cm-editor .cm-bool,
${_mode} .cm-editor .cm-null,
${_mode} .cm-editor .cm-atom { color: ${syntax.boolean}; }
${_mode} .cm-editor .cm-literal,
${_mode} .cm-editor .cm-color { color: ${syntax.constant}; }
${_mode} .cm-editor .cm-type-name,
${_mode} .cm-editor .cm-class-name { color: ${syntax.type}; }
${_mode} .cm-editor .cm-namespace { color: ${syntax.module}; }
${_mode} .cm-editor .cm-variable-name { color: ${syntax.variable}; }
${_mode} .cm-editor .cm-self { color: ${syntax.builtin_var}; }
${_mode} .cm-editor .cm-property-name { color: ${syntax.property}; }
${_mode} .cm-editor .cm-macro-name { color: ${syntax.storage}; }
${_mode} .cm-editor .cm-annotation,
${_mode} .cm-editor .cm-meta { color: ${syntax.attribute}; }
${_mode} .cm-editor .cm-operator,
${_mode} .cm-editor .cm-arithmetic-operator,
${_mode} .cm-editor .cm-logic-operator,
${_mode} .cm-editor .cm-bitwise-operator,
${_mode} .cm-editor .cm-compare-operator,
${_mode} .cm-editor .cm-update-operator,
${_mode} .cm-editor .cm-definition-operator,
${_mode} .cm-editor .cm-type-operator,
${_mode} .cm-editor .cm-control-operator,
${_mode} .cm-editor .cm-deref-operator { color: ${syntax.operator}; }
${_mode} .cm-editor .cm-punctuation,
${_mode} .cm-editor .cm-separator,
${_mode} .cm-editor .cm-bracket,
${_mode} .cm-editor .cm-brace,
${_mode} .cm-editor .cm-paren,
${_mode} .cm-editor .cm-square-bracket { color: ${syntax.punctuation}; }
${_mode} .cm-editor .cm-tag-name { color: ${syntax.tag}; }
${_mode} .cm-editor .cm-angle-bracket { color: ${syntax.punctuation}; }
${_mode} .cm-editor .cm-attribute-name { color: ${syntax.tag_attribute}; font-style: italic; }
${_mode} .cm-editor .cm-attribute-value { color: ${syntax.string}; }
${_mode} .cm-editor .cm-inserted { color: ${git.add}; }
${_mode} .cm-editor .cm-deleted { color: ${git.delete}; }
${_mode} .cm-editor .cm-changed { color: ${git.change}; }
${_mode} .cm-editor .cm-invalid { color: ${error}; text-decoration: underline wavy ${error}; }

/* ── File manager and sidebar ─────────────────────────────────────────── */
/* Zettlr paints these per platform (body.linux / .darwin / .win32); the id
   selector outranks all of them. */
${_mode} #file-manager,
${_mode} #sidebar { background-color: ${bg_dark}; color: ${fg_dark}; }
${_mode} #file-manager #file-tree,
${_mode} #file-manager #file-list,
${_mode} #file-manager .tree-item.directory:not(.collapsed),
${_mode} #file-manager div.list-item-wrapper,
${_mode} #file-manager div.list-item,
${_mode} #file-manager div.list-item div.filename div.date { background-color: ${bg_dark}; }
${_mode} #file-manager div.list-item { border-bottom-color: ${bg_highlight}; }
${_boost} #file-manager input.file-manager-filter-input { background-color: ${bg_highlight}; color: ${fg}; border-color: ${bg_widget}; }
${_boost} #file-manager input.file-manager-filter-input::placeholder { color: ${fg_muted}; }

/* ── Window chrome ────────────────────────────────────────────────────── */
/* `:not(#winteriscoming)` matches every element but counts as an id, so these
   outrank Zettlr's chrome rules (Vue scoped attributes, per-platform classes
   like body.linux.dark) without assuming any particular page structure. */
${_boost} div#window-content { background-color: ${bg_dark}; }
${_boost} #menubar { background-color: ${bg_darker}; color: ${fg_dark}; }
${_boost} div#toolbar { background-color: ${bg_dark}; color: ${fg_dark}; }
${_boost} div#toolbar button { color: ${fg_dark}; border-color: ${border}; }
${_boost} div#toolbar button:hover,
${_boost} div#toolbar button.active { background-color: ${bg_widget}; color: ${fg}; }
${_boost} div.tab-container { background-color: ${bg_darker}; }
${_boost} div.tab-container div[role="tab"] { background-color: ${bg_darker}; color: ${fg_muted}; border-color: ${bg_highlight}; }
${_boost} div.tab-container div[role="tab"]:hover { background-color: ${bg_highlight}; color: ${fg_dark}; }
${_boost} div.tab-container div[role="tab"].active { background-color: ${bg_widget}; color: ${fg_light}; border-bottom-color: ${accent}; }
${_mode} .cm-editor .cm-panels,
${_mode} .cm-editor .cm-statusbar { background-color: ${bg_dark}; color: ${fg_dark}; }
]],
    t
  )
end

return M
