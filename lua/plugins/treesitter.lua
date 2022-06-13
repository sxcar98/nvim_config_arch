require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "lua",
    "vim",
    "cpp"
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
}
