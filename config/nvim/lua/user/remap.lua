-- Map leader to space
vim.g.mapleader = " "

-- Map <leader> h to cancel highlights
vim.keymap.set("n", "<leader>h", vim.cmd.noh)

-- <leader> pv to open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- <leader> bn and <leader> bp to cycle buffers, bd to delete buffer
vim.keymap.set("n", "<C-l>", vim.cmd.bn)
vim.keymap.set("n", "<C-h>", vim.cmd.bp)
vim.keymap.set("n", "<leader>bd", vim.cmd.bd)

-- The greatest remap of all time
-- Use J and K in visual mode to move like alt+up/alt+down vscode style
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Trouble keymappings
vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>")

vim.keymap.set("n", "<C-Up>", ":resize -1<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +1<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +1<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -1<CR>")
