return {
    { 'stevearc/conform.nvim', 
    opts = {}, 
    enabled = true,

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                php = { "phpcbf" },
                -- other filetypes...
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_fallback = true,
            },
            formatters = {
                phpcbf = {
                    command = "phpcbf",
                    args = { "$FILENAME" },
                    stdin = false,
                },
            },
        })
    end,
}
}