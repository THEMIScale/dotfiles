return {
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"baliestri/aura-theme",
		lazy = false,
		priority = 1000,
		--	config = function(plugin)
		--		vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
		--		vim.cmd([[colorscheme aura-dark]])
		--	end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function(plugin)
			require("tokyonight").setup({
				style = "storm",
				transparent = true, -- 根据你的喜好
				--terminal_colors = false, -- 必须设为
			})

			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
}
