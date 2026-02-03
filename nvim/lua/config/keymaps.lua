-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })

-- Disable default C-s save (LazyVim sets it in n, i, x, s modes)
vim.keymap.del({ "n", "i", "x", "s" }, "<C-s>")
