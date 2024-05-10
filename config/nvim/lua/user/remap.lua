-- Map leader to space
vim.g.mapleader = " "

-- Map <leader> h to cancel highlights
vim.keymap.set("n", "<leader>h", vim.cmd.noh)

-- <leader> pv to open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- <leader> bn and <leader> bp to cycle buffers, bd to delete buffer
vim.keymap.set("n", "<C-l>", vim.cmd.bn)
vim.keymap.set("n", "<C-h>", vim.cmd.bp)
-- vim.keymap.set("n", "<leader>bd", vim.cmd.bd)

-- The greatest remap of all time
-- Use J and K in visual mode to move like alt+up/alt+down vscode style
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Trouble keymappings
vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>")

-- Resizing
vim.keymap.set("n", "<C-Up>", ":resize -1<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +1<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +1<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -1<CR>")

vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end)
vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end)
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end)
-- Extract variable supports only visual mode
vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end)
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end)
-- Inline var supports both normal and visual mode

vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end)
vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end)
-- Extract block supports only normal mode
