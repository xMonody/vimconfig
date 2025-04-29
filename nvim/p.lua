local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
      "labelDetails",
      "signatureHelp"
    }
  }
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
    callback = function(_)
        local clients = vim.lsp.get_clients({ name = "clangd" })
        if #clients > 0 then
            return
        end
        vim.lsp.start({
            name = "clangd",
            cmd = { "clangd", "--background-index", "--header-insertion=never",
            "--header-insertion-decorators=false", "--log=verbose", },
            root_dir = vim.fs.dirname(vim.fs.find({
            "compile_commands.json",".git","CMakeLists.txt","Makefile",".clangd"},{upward=true})[1]),
            capabilities = capabilities,
            --[[ on_attach = on_attach, ]]
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function(_)
        local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
        if #clients > 0 then
            return
        end
        vim.lsp.start({
            name = "rust_analyzer",
            cmd = { "rust-analyzer" },
            root_dir = vim.fs.dirname(vim.fs.find({
                "Cargo.toml",
                "rust-project.json"
            }, { upward = true })[1]),
            settings = {
                ["rust-analyzer"] = {
                    inlayHints = {
                        parameterHints = { enable = true },
                        typeHints = { enable = false },
                        chainingHints = { enable = true },
                        closingBraceHints = { enable = true },
                        procMacro = { enable = true },
                        closureStyleHints = { enable = true },
                        lifetimeElisionHints = { enable = false },
                        reborrowHints = { enable = false },
                        bindingModeHints = { enable = false },
                        closureCaptureHints = { enable = false },
                        discriminantHints = { enable = false },
                        expressionAdjustmentHints = { enable = "never" },
                    },
                },
            },
            --[[ on_attach = on_attach, ]]
            capabilities = capabilities,
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cmake" },
    callback = function()
        if #vim.lsp.get_clients({ name = "cmake" }) > 0 then return end

        vim.lsp.start({
            name = "cmake",
            cmd = { "cmake-language-server" },
            root_dir = vim.fs.dirname(vim.fs.find({ "CMakeLists.txt", ".git" }, { upward = true })[1]),
            init_options = {
                buildDirectory = "build"
            },
            capabilities = capabilities,
            --[[ on_attach = on_attach ]]
        })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "vs", "fs" },
    callback = function()
        if #vim.lsp.get_clients({ name = "glsl_analyzer" }) > 0 then return end
        vim.lsp.start({
            name = "glsl_analyzer",
            cmd = { "glsl-analyzer" },
            filetypes = { "glsl" },
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = vim.fn.getcwd()
        })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go" },
    callback = function()
        if #vim.lsp.get_clients({ name = "gopls" }) > 0 then return end
        vim.lsp.start({
            name = "gopls",
            cmd = { "gopls" },
            root_dir = vim.fs.dirname(vim.fs.find({ "go.mod", ".git" }, { upward = true })[1]),
            settings = {
                gopls = {
                    semanticTokens = true ,
                    hints = {
                        assignVariableTypes = true,
                        rangeVariableTypes = true,
                        parameterNames = true,
                        functionTypeParameters = true,
                    },
                },
            },
            --[[ on_attach = on_attach, ]]
            capabilities = capabilities
        })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    callback = function()
        if #vim.lsp.get_clients({ name = "tsserver" }) > 0 then return end

        vim.lsp.start({
            name = "tsserver",
            cmd = { "typescript-language-server", "--stdio" },
            root_dir = vim.fs.dirname(vim.fs.find({"package.json","tsconfig.json",".git"},{upward=true})[1]),
            settings = {
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all', --显示参数名称提示 'literals' 'none' 'all'
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,  --	显示函数参数类型提示
                        includeInlayVariableTypeHints = false, -- 显示变量类型提示
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,  --显示属性声明类型提示
                        includeInlayFunctionLikeReturnTypeHints = false,  --显示函数返回类型提示
                        includeInlayEnumMemberValueHints = true,  --显示枚举成员值提示
                    },
                },
            },
            capabilities = capabilities,
            --[[ on_attach = on_attach ]]
        })
    end
})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function(_)
        if #vim.lsp.get_clients({ name = "lua-language-server" }) > 0 then
            return
        end
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, 'lua/?.lua')
        table.insert(runtime_path, 'lua/?/init.lua')
        vim.lsp.start({
            name = "lua-language-server",
            cmd = { "lua-language-server" },
            root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'init.lua' }, { upward = true })[1]),
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = runtime_path,
                    },
                    hint = {
                        enable = true,
                        paramName = "Literal",
                        setType = true,
                    },
                    workspace = {
                        library = {
                            vim.api.nvim_get_runtime_file("", true),
                            vim.fn.expand("$VIMRUNTIME/lua"),
                            vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                            "${3rd}/luv/library",
                        },
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
            capabilities = capabilities,
            --[[ on_attach = on_attach ]]
        })
    end,
})
