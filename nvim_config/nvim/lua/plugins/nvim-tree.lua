---this document is for folder tree ------
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
    vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { desc = '打开/关闭 文件树' })

    -- (可选) 你可以在这里添加更多文件树相关的快捷键，例如：
    -- vim.keymap.set('n', '<leader>ft', ':NvimTreeFocus<CR>', { desc = '聚焦文件树' })
    -- vim.keymap.set('n', '<leader>fr', ':NvimTreeRefresh<CR>', { desc = '刷新文件树' })
  end,
}
