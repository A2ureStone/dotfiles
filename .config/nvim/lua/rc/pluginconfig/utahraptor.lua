vim.keymap.set({ "n", "x", "o" }, "n", function()
	require("utahraptor").n_flash()
end)
vim.keymap.set({ "n", "x", "o" }, "N", function()
	require("utahraptor").N_flash()
end)
