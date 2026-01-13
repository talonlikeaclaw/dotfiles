-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Exit nromal mode via "jj"
vim.keymap.set("i", "jj", "<Esc>", { silent = true })

-- Disable Ctrl + s to save and switch to "<leader>fs"
vim.keymap.del("n", "<C-s>")
vim.keymap.set("n", "<leader>fs", ":w<CR>", { desc = "Save file" })
