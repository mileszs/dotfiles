-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Restore default vim 's' behavior (delete char and enter insert mode)
vim.keymap.set({ "n", "x" }, "s", "s", { desc = "Substitute" })
