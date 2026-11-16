-- README screenshots, driven by scripts/screenshot.py (see run.sh). Steps run
-- one at a time on the event loop, so typed keys (completion, picker queries)
-- are processed between them. A step may return a function: the next step
-- waits until it returns true (or 15 s pass). Errors go to $WIC_SHOT_LOG.
local steps = {}
local function step(fn)
  steps[#steps + 1] = fn
end

local function log(msg)
  local f = io.open(vim.env.WIC_SHOT_LOG or "/dev/null", "a")
  if f then
    f:write(msg, "\n")
    f:close()
  end
end

local function run(i)
  local fn = steps[i]
  if vim.api.nvim_get_mode().blocking then
    -- a "Press ENTER" prompt would stall everything: report it and stop
    log(("step %d: blocked at a prompt:%s"):format(i, vim.fn.execute("messages")))
    fn = nil
  end
  if not fn then
    vim.rpcnotify(0, "wic_done")
    return
  end
  local ok, cond = pcall(fn)
  if not ok then
    log(("step %d: %s"):format(i, cond))
  end
  local deadline = vim.uv.now() + 15000
  local function poll()
    local ready = type(cond) ~= "function" or cond()
    if not ready and vim.uv.now() > deadline then
      log(("step %d: timed out waiting"):format(i))
      ready = true
    end
    if ready then
      vim.defer_fn(function()
        run(i + 1)
      end, 400)
    else
      vim.defer_fn(poll, 100)
    end
  end
  poll()
end

local function keys(k)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(k, true, false, true), "t", false)
end

--- Style and options for the next shots (`setup` replaces earlier options).
local function style(name, opts)
  step(function()
    require("winteriscoming").setup(opts or {})
    vim.cmd.colorscheme("winteriscoming-" .. name)
  end)
end

local function snap(name, title)
  step(function()
    vim.cmd("redraw!")
    -- an empty Lua table would arrive as a list; screenshot.py wants a dict
    vim.rpcnotify(0, "wic_snap", name, title and { title = title } or vim.empty_dict())
  end)
end

--- Wait a fixed time (diagnostics, semantic tokens and inlay hints arrive late).
local function settle(ms)
  step(function()
    local t = vim.uv.now() + ms
    return function()
      return vim.uv.now() > t
    end
  end)
end

--- Cursor at line:col with `top` as the first visible line (as in the old shots).
local function view(top, line, col)
  vim.fn.winrestview({ topline = top, lnum = line, col = col or 0 })
end

--- Leave insert mode and drop the typed edit. <Esc> alone only closes the
--- completion menu, and anything typed after it would land in the file.
local function discard()
  step(function()
    vim.cmd.stopinsert()
  end)
  step(function()
    vim.cmd("silent! edit!")
    return function()
      return not vim.bo.modified and #vim.lsp.get_clients({ bufnr = 0 }) > 0
    end
  end)
  settle(2500)
end

--- Empty `line` down to its indent, enter insert mode at its end, then type
--- `text` once blink.cmp (loaded on the first insert) is ready. Typing `cc`
--- instead would leave it in the statusline's pending-keys display.
local function type_at(line, text)
  step(function()
    vim.api.nvim_win_set_cursor(0, { line, 0 })
    vim.api.nvim_set_current_line(string.rep(" ", vim.fn.indent(line)))
    vim.cmd("startinsert!")
  end)
  settle(1000)
  step(function()
    keys(text)
  end)
end

local function close_pickers()
  step(function()
    for _, picker in ipairs(Snacks.picker.get()) do
      picker:close()
    end
  end)
end

--- True once the language server answers a hover at the cursor (right after a
--- reload it can still reply "No information available").
local function hover_ready()
  local params = vim.lsp.util.make_position_params(0, "utf-16")
  for _, res in pairs(vim.lsp.buf_request_sync(0, "textDocument/hover", params, 500) or {}) do
    if res.result and res.result.contents then
      return true
    end
  end
  return false
end

local function lsp_ready()
  return #vim.lsp.get_clients({ bufnr = 0 }) > 0
end

local function edit(path, line, col)
  step(function()
    vim.cmd.edit(path)
    vim.api.nvim_win_set_cursor(0, { line, col or 0 })
    return lsp_ready
  end)
end

local function shots()
  settle(1500)
  snap("dashboard", "winteriscoming-blue")

  -- the three styles: Python and Lua side by side
  edit("app/server.py", 33, 5)
  step(function()
    vim.cmd("rightbelow vsplit lua/plugin.lua")
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    return lsp_ready
  end)
  step(function()
    vim.cmd.wincmd("h")
    view(1, 33, 5)
  end)
  settle(3000)
  for _, s in ipairs({ "blue", "black", "light" }) do
    style(s)
    settle(500)
    snap("style-" .. s, "winteriscoming-" .. s)
  end

  step(function()
    vim.cmd.badd("src/cart.ts")
    vim.fn.bufload(vim.fn.bufnr("src/cart.ts"))
  end)
  style("black")
  step(function()
    Snacks.picker.files({ pattern = "cart" })
  end)
  settle(1500)
  snap("picker", "snacks picker · winteriscoming-black")
  close_pickers()

  -- cart.ts: explorer, completion, hover
  style("blue")
  step(function()
    vim.cmd.only()
  end)
  edit("src/cart.ts", 38, 0)
  settle(4000)
  step(function()
    Snacks.explorer.open()
  end)
  settle(1000)
  step(function()
    vim.cmd.wincmd("l")
    view(29, 38)
  end)
  type_at(38, "this.#")
  settle(2500)
  snap("hero", "src/cart.ts · winteriscoming-blue")
  discard()
  step(function()
    Snacks.explorer.open()
  end)

  style("light")
  step(function()
    view(46, 66, 20)
    return hover_ready
  end)
  step(function()
    keys("K")
  end)
  settle(2000)
  snap("hover-light", "src/cart.ts · winteriscoming-light")
  step(function()
    vim.cmd.fclose({ bang = true })
  end)
end

shots()

vim.schedule(function()
  run(1)
end)
