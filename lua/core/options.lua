-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'c' -- Enable mouse support
opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options
opt.timeoutlen = 500 -- Set leader key time gap to 250 ms

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.numberwidth = 2 -- Number column width
opt.cursorline = true -- Enable cursor line
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = 'marker' -- Enable folding (default 'foldmarker')
opt.colorcolumn = '0' -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3 -- Set global statusline
opt.scrolloff = 5 -- Always remain 5 lines at the edge of screen

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Shift 4 spaces when tab
opt.tabstop = 2 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 700 -- ms to wait for trigger an event
opt.undofile = true -- Enable undofile

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

-- Disable ruby and perl provider
g.mapleader = " "
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- set shada path
vim.schedule(function()
  opt.shadafile = vim.fn.expand "$HOME" .. "/.local/share/nvim/shada/main.shada"
  vim.cmd [[ silent! rsh ]]
end)
