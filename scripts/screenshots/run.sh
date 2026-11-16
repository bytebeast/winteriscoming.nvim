#!/usr/bin/env bash
# Rebuild the README images (screenshots, styles grid, palette sheet) into
# images/.
#
#   scripts/screenshots/run.sh
#
# Needs nvim, git, uv, and an existing LazyVim install to borrow plugins,
# treesitter parsers and language servers from (nothing is installed or
# updated). Overrides: WIC_PLUGIN_DIR (lazy.nvim plugin root), WIC_MASON_BIN,
# WIC_PARSER_DIR (the `site` dir holding parser/), WIC_FONT_DIR
# (JetBrainsMonoNerdFontMono-*.ttf).
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
repo=$(cd "$here/../.." && pwd)
mason_bin=${WIC_MASON_BIN:-$HOME/.local/share/nvim/mason/bin}
parsers=${WIC_PARSER_DIR:-$HOME/.local/share/nvim/site}
fonts=${WIC_FONT_DIR:-$HOME/Library/Fonts}

work=$(mktemp -d "${TMPDIR:-/tmp}/wic-shots.XXXXXX")
export XDG_CONFIG_HOME=$work/config XDG_STATE_HOME=$work/state XDG_CACHE_HOME=$work/cache XDG_DATA_HOME=$work/data
export UV_CACHE_DIR=${UV_CACHE_DIR:-$work/uv}
export PATH="$mason_bin:$PATH"
export WIC_SHOT_LOG=$work/scenario.log
export WIC_PLUGIN_DIR=${WIC_PLUGIN_DIR:-$HOME/.local/share/nvim/lazy}
mkdir -p "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME/nvim" "$work/shots"
# nvim-treesitter installs parsers under stdpath("data")/site
ln -s "$parsers" "$XDG_DATA_HOME/nvim/site"
echo "working in $work"

# The sample project, committed with a few lines changed afterwards, so
# gitsigns and the statusline have something to show.
cp -R "$here/samples" "$work/project"
cd "$work/project"
sed -i.bak 's/TAX_RATE: float = 0.09/TAX_RATE: float = 0.08/' app/server.py
sed -i.bak 's/local RATIO = 15/local RATIO = 16/' lua/plugin.lua
sed -i.bak -e 's/\["coffee"\] as const/["coffee", "tea"] as const/' -e 's/\.filter(Boolean)//' src/cart.ts
find . -name '*.bak' -delete
git init -q -b main --template= # skip personal hooks from init.templatedir
git add -A
GIT_CONFIG_GLOBAL=/dev/null git -c user.name=wic -c user.email=wic@localhost commit -q -m samples
cp -R "$here/samples/." .

uv run --no-project --with pynvim --with pillow python "$repo/scripts/screenshot.py" \
  --scenario "$here/scenario.lua" --out "$work/shots" --font-dir "$fonts" --frame -- -i NONE -u "$here/init.lua"

if [ -s "$WIC_SHOT_LOG" ]; then
  echo "scenario problems:" >&2
  cat "$WIC_SHOT_LOG" >&2
  exit 1
fi

cd "$repo"
uv run --no-project --with pillow python scripts/make_assets.py --shots "$work/shots" --font-dir "$fonts"
