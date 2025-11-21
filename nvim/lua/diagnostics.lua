-- format diagnostic sign's
--

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
    -- You can leave numhl/linehl nil unless you want them
    numhl = {},
    linehl = {},
  },
})

