return {
  {
    "patstockwell/vim-monokai-tasty",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[
        let g:vim_monokai_tasty_italic = 1
        let g:vim_monokai_tasty_machine_tint = 0
        colorscheme vim-monokai-tasty
      ]])
    end,
  },
}
