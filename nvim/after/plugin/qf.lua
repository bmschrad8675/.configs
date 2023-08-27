local qf = require("qf")
vim.keymap.set("n", "<leader>lo", function() qf.open('l') end) -- Open location list
vim.keymap.set("n", "<leader>lc", function() qf.close('l') end) -- Close location list
vim.keymap.set("n", "<leader>ll", function() qf.toggle('l', true) end) -- Toggle location list

vim.keymap.set("n", "<leader>co", function() qf.open('c') end) -- Open location list
vim.keymap.set("n", "<leader>cc", function() qf.close('c') end) -- Close location list
vim.keymap.set("n", "<leader>cl", function() qf.toggle('c', true) end) -- Toggle location list

vim.keymap.set("n", "<leader>j", function() qf.below('l') end) -- Close location list
vim.keymap.set("n", "<leader>k", function() qf.above('l', true) end) -- Toggle location list
