return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "Hoffs/omnisharp-extended-lsp.nvim"
    },
    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "omnisharp",
                "ts_ls",
                "jsonls"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["omnisharp"] = function()
                    require("lspconfig").omnisharp.setup {
                        capabilities = capabilities,
                        cmd = { "omnisharp" },
                        enable_import_completion = true,
                        root_dir = function(fname)
                            local util = require("lspconfig.util")
                            return util.root_pattern("*.sln", "*.slnx")(fname) or util.path.dirname(fname)
                        end,
                        organize_imports_on_format = true,
                        --enable_roslyn_analyzers = true,
                        settings = {
                            FormattingOptions = {
                                enableEditorConfigSupport = true,
                                OrganizeImports = true,
                            },
                        },
                    }

                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to Definition" })

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

        vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format" })

        vim.keymap.set("n", "<leader>i", vim.lsp.buf.code_action, { desc = "Code Action (fix imports, etc.)" })

        vim.keymap.set("n", "<leader>fm", function()
            local params = vim.lsp.util.make_formatting_params({})
            vim.lsp.buf_request(0, "textDocument/formatting", params)
        end, { desc = "Format" })

        vim.keymap.set("n", "<leader>ogd", function()
            require("omnisharp_extended").lsp_definition()
        end, { desc = "Go to Definition (OmniSharp Extended)" })

        vim.api.nvim_create_user_command('Lr', 'LspRestart', {})
    end
}