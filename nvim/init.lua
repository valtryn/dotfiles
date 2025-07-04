require('anon.custom')
-- REMAPS
vim.keymap.set('n', '<leader><leader>', vim.cmd.Ex)
vim.keymap.set('i', '<C-q>', '<Esc>')
vim.keymap.set('v', 'z', ":m '>+1<CR>gv=gv",                { desc = 'move up selected text'          })
vim.keymap.set('v', 'x', ":m '<-2<CR>gv=gv",                { desc = 'move down selected text'        })
vim.keymap.set('n', 'J', 'mzJ`z',                           { desc = 'appends the current line below' })
vim.keymap.set('n', 'K', 'mz-J`z',                          { desc = 'appends the current line below' })
vim.keymap.set('n', 'q', '<nop>',                  { noremap = true })
vim.keymap.set('n', 'Q', 'q',                      { noremap = true, desc = 'Record macro' })
vim.keymap.set('n', '<A-q>', 'Q',                  { noremap = true, desc = 'Replay last register' })
-- vim.api.nvim_set_keymap('n', '<F3>', '@q',                  { noremap = true, silent = true })
-- vim.keymap.set('n', 'M', 'K',              	   { noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'v' }, 'K', '<Nop>', 	   { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', ':set wrap!<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set('n', '<leader>o', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- SETTINGS

vim.o.clipboard = 'unnamedplus'
vim.opt.wrap = false
vim.opt.list = false
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "tab:»"
-- vim.opt.listchars:append "trail:-"
-- vim.opt.listchars:append "extends:>"
-- vim.opt.listchars:append "precedes:<"
vim.opt.listchars:append "nbsp:%"
vim.opt.guicursor = ''
vim.wo.number = true
vim.g.markdown_recommended_style = 0
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = false
vim.o.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.incsearch = true
vim.wo.signcolumn = 'yes'
vim.o.completeopt = 'menuone,noselect'
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.g.colortemplate_toolbar = 0
-- PLUGIN MANAGER

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

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
    -- UI/UX PLUGINS
    'lewis6991/gitsigns.nvim',
    'nvim-lualine/lualine.nvim',
    'onsails/lspkind.nvim',
    'valtryn/austere.vim',
    'lifepillar/vim-colortemplate',
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- BEHAVIOR PLUGINS
    'tpope/vim-sleuth',
    'tpope/vim-commentary',
    -- EXTENSION PLUGINS
    'ThePrimeagen/harpoon',
    'mbbill/undotree',
    "NvChad/nvterm",
    'sychen52/smart-term-esc.nvim',
    -- 'xiyaowong/transparent.nvim',
    -- 'jose-elias-alvarez/null-ls.nvim',
    {
      "L3MON4D3/LuaSnip",
      version = "v2.3.0",
      build = "make install_jsregexp"
    },
    {
        "williamboman/mason.nvim",
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
    -- 'nvim-tree/nvim-tree.lua',
    -- 'romgrk/barbar.nvim',
    -- 'nvim-tree/nvim-web-devicons',
    'junegunn/vim-easy-align',

})

require('anon')
