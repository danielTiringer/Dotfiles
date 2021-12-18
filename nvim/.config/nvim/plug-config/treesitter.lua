local ts = require'nvim-treesitter.configs'

ts.setup {
    ensure_installed = {
      "bash",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "php",
      "python",
      "ruby",
      "tsx",
      "typescript",
      "vim",
      "vue",
      "yaml",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
