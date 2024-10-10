local globals = {
	mapleader = " ",
	maplocalleader = " ",
	codeium_disable_bindings = 1,
	netrw_keepdir = 0,
	netrw_banner = 0,
	netrw_winsize = 30,
	netrw_liststyle = 3,
	netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) .. [[,\(^\|\s\s\)\zs\.\S\+]],
	netrw_localcopydircmd = "cp -r",
}

for k, v in pairs(globals) do
	vim.g[k] = v
end
