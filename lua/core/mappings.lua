-- mapping the leader to space
vim.g.mapleader = " "

-- custom key mappings
-- [normal mode]
vim.keymap.set("n", "H", "^") -- move the cursor to the start of the current line
vim.keymap.set("n", "L", "$") -- move the cursor to the end of the current line
vim.keymap.set("n", "<C-j>", "<C-w>j") -- move the cursor from the top split to the split below
vim.keymap.set("n", "<C-k>", "<C-w>k") -- move the cursor from the top split to the split above
vim.keymap.set("n", "<C-h>", "<C-w>h") -- move the cursor from the top split to the split left
vim.keymap.set("n", "<C-l>", "<C-w>l") -- move the cursor from the top split to the split right
vim.keymap.set("n", "<leader>q", "<C-w>q") -- close the current split
vim.keymap.set("n", "<leader>h", ":noh<CR>") -- remove the highlight till the next search
vim.keymap.set("n", "<C-t>", "<C-w><C-r>") -- Swap the splits

-- [visual mode] custom key mappings
vim.keymap.set("v", "H", "^") -- move the cursor to the start of the current line
vim.keymap.set("v", "L", "$") -- move the cursor to the start of the current line

-- [command mode] custom key mappings -- [experimental]
vim.keymap.set("c", "H", "^") -- move the cursor to the start of the current line
vim.keymap.set("c", "L", "$") -- move the cursor to the start of the current line


-- plugin specific mappings
-- [Telescope]
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', builtin.find_files, {desc = "Open a file from the current project"})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {desc = "Grep inside the project"})
vim.keymap.set('n', '<C-p>', builtin.buffers, {desc = "Show the buffers already open"})
vim.keymap.set('n', '<leader>d', builtin.help_tags, {desc = "Show the help tags present for Telescope"})
