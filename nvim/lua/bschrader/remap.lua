vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Location and Quickfix toggles
local noremap_silent = { noremap = true, silent = true }
vim.keymap.set('n', '=l', function()
    local win = vim.api.nvim_get_current_win()
    local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
    local action = qf_winid > 0 and 'lclose' or 'lopen'
    vim.cmd(action)
end, noremap_silent)

vim.keymap.set('n', '=q', function()
    local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
    local action = qf_winid > 0 and 'cclose' or 'copen'
    vim.cmd('botright '..action)
end, noremap_silent)

vim.keymap.set('n', '[q', 'cprevious')
vim.keymap.set('n', ']q', 'cnext')

-- Tab navigation
vim.keymap.set('n', '<leader>tn', vim.cmd.tabNext)
vim.keymap.set('n', '<leader>tN', vim.cmd.tabnew)
