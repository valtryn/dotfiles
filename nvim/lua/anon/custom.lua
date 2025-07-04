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

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.h",
  command = "set filetype=c"
})
-- vim.api.nvim_set_keymap('n', '<F2>', ':Inspect<CR>', { noremap = true})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "h" },
  callback = function()
    vim.bo.commentstring = "//%s"
  end,
})

