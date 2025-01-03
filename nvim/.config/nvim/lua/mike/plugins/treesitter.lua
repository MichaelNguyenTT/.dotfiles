return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({
            modules = {},
            ignore_install = {},
            -- ensure these language parsers are installed
            ensure_installed = {
                "json",
                "javascript",
                "typescript",
                "yaml",
                "html",
                "css",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "go",
                "java",
                "make",
                "templ",
                "c",
            },
            sync_install = false,
            auto_install = true,

            -- enable syntax highlighting
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    if lang == "html" then
                        print("disabled")
                        return true
                    end

                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        vim.notify(
                            "FILE larger than 100KB treesitter disabled for performance xd",
                            vim.log.levels.WARN,
                            { title = "Treesitter" }
                        )
                        return true
                    end
                end,

                additional_vim_regex_highlighting = false
            },

            -- enable indentation
            indent = { enable = true },
        })
    end,
}
