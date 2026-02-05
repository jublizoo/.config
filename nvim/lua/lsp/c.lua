vim.lsp.config['clangd'] = {
	cmd = {
		"clangd",
		"--log=verbose",
		"--background-index",
		"--clang-tidy",
	},
}

vim.keymap.set('n', '<leader>h', "<cmd>LspClangdSwitchSourceHeader<cr>")
