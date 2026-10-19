local Config = require("winteriscoming.config")
local Util = require("winteriscoming.util")

local M = {}

-- lazy.nvim plugin name -> integration module in this folder
-- stylua: ignore
M.plugins = {
  ["aerial.nvim"]                 = "aerial",
  ["alpha-nvim"]                  = "alpha",
  ["avante.nvim"]                 = "avante",
  ["blink.cmp"]                   = "blink",
  ["bufferline.nvim"]             = "bufferline",
  ["codecompanion.nvim"]          = "codecompanion",
  ["copilot.lua"]                 = "copilot",
  ["dashboard-nvim"]              = "dashboard",
  ["diffview.nvim"]               = "diffview",
  ["fidget.nvim"]                 = "fidget",
  ["flash.nvim"]                  = "flash",
  ["fzf-lua"]                     = "fzf",
  ["gitsigns.nvim"]               = "gitsigns",
  ["grug-far.nvim"]               = "grug-far",
  ["harpoon"]                     = "harpoon",
  ["headlines.nvim"]              = "headlines",
  ["indent-blankline.nvim"]       = "indent-blankline",
  ["lazy.nvim"]                   = "lazy",
  ["leap.nvim"]                   = "leap",
  ["lspsaga.nvim"]                = "lspsaga",
  ["mason.nvim"]                  = "mason",
  ["mini.animate"]                = "mini_animate",
  ["mini.clue"]                   = "mini_clue",
  ["mini.cursorword"]             = "mini_cursorword",
  ["mini.diff"]                   = "mini_diff",
  ["mini.files"]                  = "mini_files",
  ["mini.hipatterns"]             = "mini_hipatterns",
  ["mini.icons"]                  = "mini_icons",
  ["mini.indentscope"]            = "mini_indentscope",
  ["mini.jump"]                   = "mini_jump",
  ["mini.pick"]                   = "mini_pick",
  ["mini.starter"]                = "mini_starter",
  ["mini.statusline"]             = "mini_statusline",
  ["mini.surround"]               = "mini_surround",
  ["mini.tabline"]                = "mini_tabline",
  ["neo-tree.nvim"]               = "neo-tree",
  ["neogit"]                      = "neogit",
  ["neotest"]                     = "neotest",
  ["noice.nvim"]                  = "noice",
  ["nvim-cmp"]                    = "cmp",
  ["nvim-dap"]                    = "dap",
  ["nvim-dap-ui"]                 = "dap-ui",
  ["nvim-navic"]                  = "navic",
  ["nvim-notify"]                 = "notify",
  ["nvim-tree.lua"]               = "nvim-tree",
  ["nvim-treesitter-context"]     = "treesitter-context",
  ["nvim-ufo"]                    = "ufo",
  ["oil.nvim"]                    = "oil",
  ["rainbow-delimiters.nvim"]     = "rainbow",
  ["render-markdown.nvim"]        = "render-markdown",
  ["sidekick.nvim"]               = "sidekick",
  ["snacks.nvim"]                 = "snacks",
  ["telescope.nvim"]              = "telescope",
  ["todo-comments.nvim"]          = "todo-comments",
  ["trouble.nvim"]                = "trouble",
  ["vim-illuminate"]              = "illuminate",
  ["which-key.nvim"]              = "which-key",
  ["yanky.nvim"]                  = "yanky",
}

function M.get_group(name)
  return Util.mod("winteriscoming.groups." .. name)
end

---@param colors winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(name, colors, opts)
  return M.get_group(name).get(colors, opts)
end

---@param colors winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.setup(colors, opts)
  local groups = {
    base = true,
    kinds = true,
    semantic_tokens = true,
    treesitter = true,
  }

  if opts.plugins.all then
    for _, group in pairs(M.plugins) do
      groups[group] = true
    end
  elseif opts.plugins.auto and package.loaded.lazy then
    local plugins = require("lazy.core.config").plugins
    for plugin, group in pairs(M.plugins) do
      if plugins[plugin] then
        groups[group] = true
      end
    end
    -- mini.nvim as a single plugin enables every mini module
    if plugins["mini.nvim"] then
      for _, group in pairs(M.plugins) do
        if group:find("^mini_") then
          groups[group] = true
        end
      end
    end
  end

  -- manual overrides, by integration name or by plugin name
  for plugin, group in pairs(M.plugins) do
    local use = opts.plugins[group]
    use = use == nil and opts.plugins[plugin] or use
    if use ~= nil then
      if type(use) == "table" then
        use = use.enabled
      end
      groups[group] = use or nil
    end
  end

  local names = vim.tbl_keys(groups)
  table.sort(names)

  local cache_key = opts.style
  local cache = opts.cache and Util.cache.read(cache_key)

  local inputs = {
    colors = colors,
    plugins = names,
    version = Config.version,
    opts = {
      transparent = opts.transparent,
      styles = opts.styles,
      dim_inactive = opts.dim_inactive,
      italics = opts.italics,
      bold = opts.bold,
      bright_line_numbers = opts.bright_line_numbers,
      faithful = opts.faithful,
    },
  }

  local ret = cache and vim.deep_equal(inputs, cache.inputs) and cache.groups

  if not ret then
    ret = {}
    for group in pairs(groups) do
      for k, v in pairs(M.get(group, colors, opts)) do
        ret[k] = v
      end
    end
    Util.resolve(ret, opts)
    if opts.cache then
      Util.cache.write(cache_key, { groups = ret, inputs = inputs })
    end
  end
  opts.on_highlights(ret, colors)

  return ret, groups
end

return M
