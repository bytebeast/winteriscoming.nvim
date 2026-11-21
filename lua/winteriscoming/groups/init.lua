local Config = require("winteriscoming.config")
local Util = require("winteriscoming.util")

local M = {}

-- plugin name (as lazy.nvim / vim.pack see it) -> integration module in this folder
-- stylua: ignore
M.plugins = {
  ["aerial.nvim"]                 = "aerial",
  ["alpha-nvim"]                  = "alpha",
  ["avante.nvim"]                 = "avante",
  ["barbar.nvim"]                 = "barbar",
  ["blink.cmp"]                   = "blink",
  ["blink.pairs"]                 = "blink-pairs",
  ["bufferline.nvim"]             = "bufferline",
  ["coc.nvim"]                    = "coc",
  ["codecompanion.nvim"]          = "codecompanion",
  ["codediff.nvim"]               = "codediff",
  ["copilot.lua"]                 = "copilot",
  ["copilot.vim"]                 = "copilot",
  ["dashboard-nvim"]              = "dashboard",
  ["diffview.nvim"]               = "diffview",
  ["dropbar.nvim"]                = "dropbar",
  ["fidget.nvim"]                 = "fidget",
  ["flash.nvim"]                  = "flash",
  ["fzf-lua"]                     = "fzf",
  ["git-conflict.nvim"]           = "git-conflict",
  ["gitsigns.nvim"]               = "gitsigns",
  ["grug-far.nvim"]               = "grug-far",
  ["harpoon"]                     = "harpoon",
  ["headlines.nvim"]              = "headlines",
  ["hlargs.nvim"]                 = "hlargs",
  ["hop.nvim"]                    = "hop",
  ["hover.nvim"]                  = "hover",
  ["indent-blankline.nvim"]       = "indent-blankline",
  ["lazy.nvim"]                   = "lazy",
  ["leap.nvim"]                   = "leap",
  ["lspsaga.nvim"]                = "lspsaga",
  ["markview.nvim"]               = "markview",
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
  ["minuet-ai.nvim"]              = "minuet",
  ["neo-tree.nvim"]               = "neo-tree",
  ["neogit"]                      = "neogit",
  ["neotest"]                     = "neotest",
  ["noice.nvim"]                  = "noice",
  ["nvim-bufferline.lua"]         = "bufferline",
  ["nvim-cmp"]                    = "cmp",
  ["nvim-cursorword"]             = "cursorword",
  ["nvim-dap"]                    = "dap",
  ["nvim-dap-ui"]                 = "dap-ui",
  ["nvim-navic"]                  = "navic",
  ["nvim-notify"]                 = "notify",
  ["nvim-scrollbar"]              = "scrollbar",
  ["nvim-tree.lua"]               = "nvim-tree",
  ["nvim-treesitter-context"]     = "treesitter-context",
  ["nvim-ufo"]                    = "ufo",
  ["octo.nvim"]                   = "octo",
  ["oil.nvim"]                    = "oil",
  ["orgmode"]                     = "orgmode",
  ["outline.nvim"]                = "outline",
  ["overseer.nvim"]               = "overseer",
  ["rainbow-delimiters.nvim"]     = "rainbow",
  ["render-markdown.nvim"]        = "render-markdown",
  ["sidekick.nvim"]               = "sidekick",
  ["snacks.nvim"]                 = "snacks",
  ["telescope-file-browser.nvim"] = "telescope",
  ["telescope.nvim"]              = "telescope",
  ["todo-comments.nvim"]          = "todo-comments",
  ["trouble.nvim"]                = "trouble",
  ["vim-gitgutter"]               = "gitgutter",
  ["vim-illuminate"]              = "illuminate",
  ["virt-column.nvim"]            = "virt-column",
  ["which-key.nvim"]              = "which-key",
  ["yanky.nvim"]                  = "yanky",
}

--- Plugin names known to lazy.nvim and/or vim.pack (Neovim 0.12+).
---@return table<string, boolean>? names, nil when no supported manager is loaded
function M.installed()
  local found, any = {}, false
  if package.loaded["lazy"] or package.loaded["lazy.core.config"] then
    local ok, cfg = pcall(require, "lazy.core.config")
    if ok and cfg.plugins then
      any = true
      for name in pairs(cfg.plugins) do
        found[name] = true
      end
    end
  end
  -- Only ask vim.pack when the user's config actually loaded it: the query
  -- costs ~1 ms, which lazy.nvim users shouldn't pay on every startup.
  if package.loaded["vim.pack"] and vim.pack.get then
    local ok, list = pcall(vim.pack.get, nil, { info = false })
    if ok and type(list) == "table" then
      any = any or #list > 0
      for _, p in ipairs(list) do
        local name = p.spec and p.spec.name
        if name then
          found[name] = true
        end
      end
    end
  end
  return any and found or nil
end

function M.get_group(name)
  return Util.mod("winteriscoming.groups." .. name)
end

---@param colors winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(name, colors, opts)
  return M.get_group(name).get(colors, opts)
end

--- Integrations to load, as a set of module names.
---@param opts winteriscoming.Config
---@return table<string, boolean>
function M.enabled(opts)
  local groups = {}

  local installed = opts.plugins.auto ~= false and M.installed() or nil
  local all = opts.plugins.all
  if all == nil then
    all = installed == nil -- no plugin manager we understand: load everything
  end

  if all then
    for _, group in pairs(M.plugins) do
      groups[group] = true
    end
  elseif installed then
    for plugin, group in pairs(M.plugins) do
      if installed[plugin] then
        groups[group] = true
      end
    end
    -- mini.nvim as a single plugin enables every mini module
    if installed["mini.nvim"] then
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
    if use == nil then
      use = opts.plugins[plugin]
    end
    if use ~= nil then
      if type(use) == "table" then
        use = use.enabled
      end
      groups[group] = use or nil
    end
  end
  return groups
end

---@param colors winteriscoming.ColorScheme
---@param opts winteriscoming.Config
---@param integrations? table<string, boolean> defaults to `M.enabled(opts)`
function M.setup(colors, opts, integrations)
  local groups = vim.deepcopy(integrations or M.enabled(opts))
  for _, core in ipairs({ "base", "kinds", "semantic_tokens", "treesitter" }) do
    groups[core] = true
  end

  local names = vim.tbl_keys(groups)
  table.sort(names)

  local cache_key = opts.style
  local cache = opts.cache and Util.cache.read(cache_key)

  -- every option that can change a group; hooks can't be compared, plugins
  -- are covered by `names`
  local inputs = { colors = colors, plugins = names, version = Config.version, opts = {} }
  for k, v in pairs(opts) do
    if type(v) ~= "function" and k ~= "plugins" and k ~= "cache" then
      inputs.opts[k] = v
    end
  end

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
