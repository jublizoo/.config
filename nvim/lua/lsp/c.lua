vim.lsp.config['clangd'] = {
	cmd = {
		"clangd",
		"--log=error",
		"--background-index",
		"--header-insertion=never",
		"--compile-commands-dir=/home/jam-hennessy/memsql-clangd",
		-- Allow clangd to query the host compiler for system includes.
		-- The compile DB points at the builder's clang, which is not on the host.
		"--query-driver=/usr/bin/clang++-15,/usr/local/clang+llvm*/bin/clang++",
	},
}

vim.keymap.set('n', '<leader>h', "<cmd>LspClangdSwitchSourceHeader<cr>")

-- Clangd setup
-- 
-- Uses generated compile_commands.json, and manual .clangd
--
-- See .clangd for:
-- 		- Parsing despite errors
-- 		- Disabling clang tidy
-- 		- Removes path to llvm dependency header files
-- 			- compile_commands.json points to LLVM path in build container.
-- 		- Adds include header paths for local copy of build container LLVM headers

-- Created `~/.cache/memsql-clangd/`
-- 		- `stub/sys/sdt`: Contains stub, which is replacement for real header 
-- 		(not found by clangd). This is sufficient for parsing, but it does not
-- 		include the real macros.
-- 		- `llvm-include/`: Contains a full copy of `/usr/local/clang+llvm-13.0.0/bin/clang++/`.
-- 		This is the path 
--
-- 	compile_commands.json is still used for indexing project files.
