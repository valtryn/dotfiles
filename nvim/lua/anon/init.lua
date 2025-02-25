-- [[ THEME ]]

-- No clown fiesta
-- require("no-clown-fiesta").setup({
--   transparent = false, -- Enable this to disable the bg color
--   styles = {
--     -- You can set any of the style values specified for `:h nvim_set_hl`
--     comments = {},
--     functions = {},
--     keywords = {},
--     lsp = { underline = true },
--     match_paren = {},
--     type = { bold = true },
--     variables = {},
--   },
-- })
vim.cmd[[colorscheme austere]]
-- ++ Gruber Darker ++
-- require("gruber-darker").setup({
--   bold = true,
--     undercurl = true,
--     underline = true,
--     invert = { signs   = false, tabline  =  false, visual    = false, },
--     italic = { strings = false, comments =  false, operators = false, folds = false, }
-- })
-- vim.cmd.colorscheme 'gruber-darker'
-- cursor settings
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
-- vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FFDD33', bg = '#FFDD33', bold = false })
-- make everything transparent
-- require("transparent").setup({ -- Optional, you don't have to run setup.
--     groups = {                 -- table: default groups
--         'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
--         'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
--         'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
--         'SignColumn', 'CursorLineNr', 'EndOfBuffer',
--     },
--     extra_groups = {},   -- table: additional groups that should be cleared
--     exclude_groups = {}, -- table: groups you don't want to clear
-- })
-- vim.g.transparent_enabled = true


-- ++ GIT SIGNS ++
require("gitsigns").setup({
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
})
-- ++ Lualine
require("lualine").setup({
    options = {
      theme = 'auto',
      icons_enabled = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
})

-- [[ TELESCOPE ]]
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,      { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers'      })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>f', function()
  require('telescope.builtin').find_files({
    no_ignore = true
  })
end, { desc = 'Search files' })
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files,  { desc = '[S]earch [F]iles'        })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags,   { desc = '[S]earch [H]elp'         })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sl', require('telescope.builtin').live_grep,   { desc = '[S]earch by [G]rep'      })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics'  })
-- [[ CONFIGURE TREESITTER ]]
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'html', 'css', 'scss', 'json', 'javascript' },
  auto_install = true,
  highlight = { enable = false },
  indent = { enable = false, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- [[ LSP ]]
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('M', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  html = {},
  cssls = {},
  gopls = {
    settings = {
      goimports = true,
      gofumpt = true,
    }
  },
  pyright = {},
  -- flake8 = {},
  quick_lint_js = {},
  svelte = {},
  -- prettier = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- [[ CMP ]]
local cmp = require 'cmp'
local luasnip = require 'luasnip'
-- local lspkind = require('lspkind')
luasnip.config.setup {}

cmp.setup {
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false -- this feature conflict with copilot.vim's preview.
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  preselect = cmp.PreselectMode.None,
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return require('lspkind').cmp_format { with_text = true } (entry, vim_item)
    end,
  },
}


-- [[ SMART TERM ESC ]]
require('smart-term-esc').setup {
    key = '<Esc>',
    except = { 'nvim', 'fzf' }
}

-- [[ HARPOOON ]]
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>ha', mark.add_file)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

vim.keymap.set('n', '<C-a>', function()
    ui.nav_file(1)
end)
vim.keymap.set('n', '<C-s>', function()
     ui.nav_file(2)
end)
vim.keymap.set('n', '<C-z>', function()
      ui.nav_file(3)
end)
vim.keymap.set('n', '<C-x>', function()
      ui.nav_file(4)
end)


-- [[ NVTERM ]]
require("nvterm").setup({
    terminals = {
        shell = vim.o.shell,
        list = {},
        type_opts = {
            float = {
                relative = 'editor',
                row = 0.25,
                col = 0.25,
                width = 0.5,
                height = 0.5,
                border = "none",
            },
            horizontal = { location = "rightbelow", split_ratio = .3, },
            vertical   = { location = "rightbelow", split_ratio = .5 },
        }
    },
    behavior = {
        autoclose_on_quit = {
            enabled = false,
            confirm = true,
        },
        close_on_exit = true,
        auto_insert = true,
    },
})
vim.keymap.set({ 'n', 't' }, '<A-t>',
  function()
    require("nvterm.terminal").toggle "float"
  end
)

vim.keymap.set({ 'n', 't' }, '<A-s>',
  function()
    require("nvterm.terminal").toggle "horizontal"
  end
)

vim.keymap.set({ 'n', 't' }, '<A-v>',
  function()
    require("nvterm.terminal").toggle "vertical"
  end
)


-- [[ NULL-LS ]]
local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
null_ls.setup {
  sources = {
    formatting.prettier.with({ extra_args = { '--tab-width=4', '--use-tab' } }),
    formatting.gofumpt,
    formatting.goimports,
    -- diagnostics.eslint_d,
    diagnostics.flake8,
    -- null_ls.builtins.completion.spell,
  },
}


-- [[ MISC ]]
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
