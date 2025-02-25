-- [[ REMAPS ]]

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('i', '<C-q>', '<Esc>')
vim.keymap.set('n', '<A-\'>', vim.cmd.bnext,                { desc = 'Go back to next buffer'            })
vim.keymap.set('n', '<A-;>', vim.cmd.bprevious,             { desc = 'Go back to previous buffer'        })
vim.keymap.set('v', 'z', ":m '>+1<CR>gv=gv",                { desc = 'move up selected text'             })
vim.keymap.set('v', 'x', ":m '<-2<CR>gv=gv",                { desc = 'move down selected text'           })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,         { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,         { desc = "Go to next diagnostic message"     })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message"  })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list"             })

vim.keymap.set('v', 'M', 'K', { noremap = true })
vim.keymap.set('v', 'K', '<Nop>', { noremap = true })

vim.keymap.set('n', 'J', 'mzJ`z',                           { desc = 'appends the current line above while the cursor is till in the beginning of the line?' })
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set('n', '<leader>o', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- [[ SETTINGS ]]
vim.opt.list = false
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "tab:»"
-- vim.opt.listchars:append "trail:-"
-- vim.opt.listchars:append "extends:>"
-- vim.opt.listchars:append "precedes:<"
vim.opt.listchars:append "nbsp:%"
vim.opt.guicursor = ''
vim.o.hlsearch = false
vim.wo.number = true
vim.g.markdown_recommended_style = 0
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = false
vim.o.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50


-- [[ Commands ]]

-- ++ Indent ++
-- values: softtabstop, expandtab, shiftwidth, tabstop
-- start: this is dogshit, rewrite this
local indent_opt = {
    tab    = { 8, false, 8, 8 },
    spaces = { 4, true,  4, 4 },
}

local tabs   = { 'go',  'c', '*.c' }
local spaces = { 'lua', 'css', 'python', 'java', 'scss', 'html', 'json' }

local function set_indent(opt)
  vim.opt_local.softtabstop = indent_opt[opt][1]
  vim.opt_local.expandtab   = indent_opt[opt][2]
  vim.opt_local.shiftwidth  = indent_opt[opt][3]
  vim.opt_local.tabstop     = indent_opt[opt][4]
end

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter', 'FileType' }, {
  pattern  = tabs,
  callback = function() set_indent("tab") end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern  = spaces,
  callback = function() set_indent("spaces") end
})
-- end

-- ++ Highlight on yank ++
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ PLUGIN MANAGER ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'tpope/vim-sleuth',
    'blazkowolf/gruber-darker.nvim',
    'aktersnurra/no-clown-fiesta.nvim',
    'LuRsT/austere.vim',
    'xiyaowong/transparent.nvim',
    'onsails/lspkind.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-lualine/lualine.nvim',
    'ThePrimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-commentary',
    "NvChad/nvterm",
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.1.1", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      -- build = "make install_jsregexp"
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },
    {
        'sychen52/smart-term-esc.nvim',
        config = function()
        end
    },
    {
      "folke/trouble.nvim",
      -- dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = { },
    },
    { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'nvim-treesitter/nvim-treesitter', dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', },
         config = function()
           pcall(require('nvim-treesitter.install').update { with_sync = true })
         end,
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',
        {
          "j-hui/fidget.nvim",
          tag = "legacy",
          event = "LspAttach",
          opts = { },
        },
        'folke/neodev.nvim',
      },
    },
    { 'hrsh7th/nvim-cmp', dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' }, },
    { 'folke/which-key.nvim',
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
})

require("anon")
