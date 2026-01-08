-- 对应第1行: syntax on
vim.cmd("syntax enable")

-- 基础缩进设置（针对所有文件类型）
vim.opt.tabstop = 4 -- 一个Tab键在屏幕上显示为4个空格的宽度
vim.opt.shiftwidth = 4 -- 自动缩进（如 `>>`, `<<`）和某些代码格式化工具使用的缩进量为4个空格
vim.opt.softtabstop = 4 -- 在按Tab键时，在插入模式感觉上是4个空格的宽度

-- 设置全局leader键为空格（一种流行选择）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 对应第5行: set autoindent
vim.opt.autoindent = true

-- 对应第6行: set number
vim.opt.number = true

-- 对应第8行: set ruler
vim.opt.ruler = true

-- 对应第9行: set laststatus=2
vim.opt.laststatus = 2

--  set t_Co=256
vim.opt.termguicolors = true -- Neovim 中启用真彩色的现代方式

--  set cursorline
vim.opt.cursorline = true

require("config.lazy")

-- 透明背景设置 (需在 colorscheme 命令后执行)
-- 主编辑区背景
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 浮动窗口背景
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 非文本字符（如行尾空格标识符）背景
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
-- 缓冲区末尾（文件结束后的空白区域）背景
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- 行号列背景
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- 标记列（用于显示 Git 更改标记、诊断图标等）背景
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- I dont know what's this for
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

-- 一级浮窗 (主要补全/提示窗口) - 使用深色半透明背景
vim.api.nvim_set_hl(0, "NormalFloat", {
	bg = "#1a1a2e", -- 深蓝色背景，可调整颜色
	blend = 15, -- 透明度 (0-100，值越小越透明)
	fg = "#c8d3f5", -- 浅色文字
})

-- 为浮窗添加边框（更清晰的视觉区分）
vim.api.nvim_set_hl(0, "FloatBorder", {
	bg = "#1a1a2e", -- 与 NormalFloat 背景一致
	fg = "#7a88cf", -- 边框颜色（稍亮于背景）
})

-- 二级浮窗 (coc 详细文档/提示) - 稍深背景
vim.api.nvim_set_hl(0, "CocFloating", { -- coc 专用浮窗
	bg = "#16162c",
	blend = 20, -- 稍低透明度
	fg = "#c8d3f5",
})

-- 示例：将下划线改为亮红色虚线
vim.api.nvim_set_hl(0, "CursorLineNr", {
	bg = "none",
	underline = true,
	undercurl = false, -- 确保是直线，不是曲线
	sp = "#ff0000", -- 设置下划线颜色 (sp 是 ‘special’ 的缩写)
})

vim.api.nvim_set_hl(0, "CursorLine", {
	bg = "none",
	underline = true,
	undercurl = false, -- 确保是直线，不是曲线
	sp = "#ff0000", -- 设置下划线颜色 (sp 是 ‘special’ 的缩写)
})

-- 启用系统剪贴板共享
vim.opt.clipboard = "unnamedplus"

----------following are coc---------
-- https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.lua

-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "auto:1"
vim.opt.numberwidth = 2

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window
function _G.show_docs()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end
keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
	group = "CocGroup",
	command = "silent call CocActionAsync('highlight')",
	desc = "Highlight symbol under cursor on CursorHold",
})

-- Symbol renaming
-- keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Formatting selected code
-- keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
-- keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
	group = "CocGroup",
	pattern = "typescript,json",
	command = "setl formatexpr=CocAction('formatSelected')",
	desc = "Setup formatexpr specified filetype(s).",
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
-- local opts = {silent = true, nowait = true, expr = true}
-- keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
-- keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
-- keyset("i", "<C-f>",
--       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
-- keyset("i", "<C-b>",
--       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
-- keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
-- keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
-- Show all diagnostics
-- keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
-- keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
-- keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
--keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
-- keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
-- keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
-- keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
-- keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

----------------coc over----------------
------------speed ways--------------------------
-- 如果你想用 <leader> 键，并确保它干净，比如用 <leader>tt
vim.keymap.set("n", "<leader>tt", ":vertical belowright split | terminal<CR>", { desc = "打开终端" })
