return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			blue = "#80a0ff",
			cyan = "#79dac8",
			black = "#080808",
			white = "#c6c6c6",
			red = "#ff0000",
			violet = "#d183e8",
			grey = "#303030",
			kl_blue = "#002fa7",
			kl_blue_2 = "#005bcc",
			kl_green = "#00d0a5",
			yellow = "#ffff00",
			gold = "#ffd700",
			navy_blue = "#000080",
			insert_per = "#7cb3c5",
			insert_loc = "e8d5b5",
			visual_ori = "#228b22",
			visual_per = "#7a9972",
			visual_loc = "#f1fded",
			command_ori = "#800080",
			command_per = "#ac84a8",
			command_loc = "#fff5ff",
			grave_tiem = "#2a272a",
			terminal_per = "#009b49",
			terminal_loc = "#0082ff",
		}

		local bubbles_theme = {
			normal = {
				a = { fg = colors.white, bg = colors.kl_blue },
				b = { fg = colors.black, bg = colors.kl_blue_2 },
				-- b = {},
				c = { fg = colors.white },
				z = { fg = colors.black, bg = colors.kl_blue },
			},
			insert = { a = { fg = colors.white, bg = colors.navy_blue }, z = a },
			visual = { a = { fg = colors.black, bg = colors.visual_ori }, z = a },
			command = { a = { fg = colors.black, bg = colors.command_ori }, z = a },
			replace = { a = { fg = colors.black, bg = colors.red } },
			terminal = { a = { fg = colors.yellow, bg = colors.red } },
			inactive = {
				a = { fg = colors.white, bg = colors.black },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.white },
			},
		}

		require("lualine").setup({
			options = {
				theme = bubbles_theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "", right = "" }, padding = { left = 1, right = 1 } },
				},
				lualine_b = {},
				lualine_c = { { "filename", path = 3 } },
				lualine_x = { "filetype" },
				lualine_y = {},
				lualine_z = {
					{
						function()
							if vim.fn.mode() == "i" then
								return "󰨞"
							elseif vim.fn.mode() == "v" then
								return ""
							elseif vim.fn.mode() == "c" then
								return "󱅧" -- return "󰪭"
							elseif vim.fn.mode() == "t" then
								return "󱢇"
							else
								return ""
							end
						end,
						padding = { left = 1, right = 2 },
						color = function(self) -- color of icons above
							if vim.fn.mode() == "i" then
								return { fg = colors.yellow }
							elseif vim.fn.mode() == "v" then
								return { fg = colors.navy_blue }
							elseif vim.fn.mode() == "c" then
								return { fg = colors.gold }
							elseif vim.fn.mode() == "t" then
								return { fg = colors.yellow }
							else
								return { fg = colors.yellow }
							end
						end,
					},
					{
						function()
							return ""
						end,
						padding = { left = 0, right = 0 },
						color = function(self)
							if vim.fn.mode() == "i" then
								return { fg = colors.insert_per }
							elseif vim.fn.mode() == "v" then
								return { fg = colors.visual_per }
							elseif vim.fn.mode() == "c" then
								return { fg = colors.command_per }
							elseif vim.fn.mode() == "t" then
								return { fg = colors.terminal_per }
							else
								return { fg = colors.kl_blue_2 }
							end
						end,
					},
					{
						"progress",
						color = function(self)
							if vim.fn.mode() == "i" then
								return { bg = colors.insert_per, fg = colors.black }
							elseif vim.fn.mode() == "v" then
								return { bg = colors.visual_per }
							elseif vim.fn.mode() == "c" then
								return { bg = colors.command_per }
							elseif vim.fn.mode() == "t" then
								return { bg = colors.terminal_per, fg = colors.black }
							else
								return { bg = colors.kl_blue_2, fg = colors.balck }
							end
						end,
					},

					{
						"location",
						separator = { left = "", right = "" },
						padding = { left = 0, right = 0 },
						color = function(self)
							--return { bg = colors.kl_green, fg = colors.black }
							if vim.fn.mode() == "i" then
								return { bg = colors.insert_loc, fg = colors.black }
							elseif vim.fn.mode() == "v" then
								return { bg = colors.visual_loc, fg = colors.black }
							elseif vim.fn.mode() == "c" then
								return { bg = colors.command_loc }
							elseif vim.fn.mode() == "t" then
								return { bg = colors.terminal_loc, fg = colors.black }
							else
								return { bg = colors.kl_green, fg = colors.black }
							end
						end,
					},
				},
			},

			inactive_sections = {
				lualine_a = { { "filename", separator = { left = "", right = "" } } },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {
					{
						function()
							return ""
						end,
						color = { fg = colors.white },
						padding = { right = 0 },
					},
					{
						function()
							return "󰮢"
						end,
						color = { bg = colors.white, fg = colors.black },
						padding = { left = 1, right = 1 },
					},
				},
				lualine_y = {},
				lualine_z = { { "location", separator = { left = "", right = "" } } },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
