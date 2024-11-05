return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("onedark").load()
	-- 	end,
	-- },
}