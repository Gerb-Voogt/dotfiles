local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>bf", builtin.buffers, {})
vim.keymap.set("n", "<leader>sf", builtin.lsp_document_symbols, {})
