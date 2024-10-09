return {
     {
		"xiyaowong/nvim-transparent",
		lazy = false,
		priority = 999,
	},
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            -- Load the colorscheme here
            vim.cmd([[colorscheme catppuccin]])
        end,
    }
}
