return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		-- 1. 定义各文件类型对应的格式化器
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			-- 其他语言...
			-- python = { "isort", "black" },
		},
		-- 2. 【关键】设置保存时自动格式化
		format_on_save = {
			-- 为特定文件类型启用（这里启用了所有在 formatters_by_ft 中定义的类型）
			-- 你也可以用 lsp_fallback 模式，它会先尝试LSP格式化，失败后再用这里定义的格式化器
			lsp_fallback = true,
			-- 全局超时时间（毫秒），如果格式化很慢可以适当增加
			timeout_ms = 2000,
		},
		-- 3. （可选）自定义格式化器参数
		formatters = {
			["clang-format"] = {
				args = '--style="{IndentWidth: 4, UseTab: Always}"',
				-- 例如，强制使用某种代码风格，或指定配置文件
				-- args = { "--style=LLVM" },
			},
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
