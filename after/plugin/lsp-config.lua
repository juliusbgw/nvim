-- Setup language servers.
--local vim.lsp.config = vim.lsp.config("")
--vim.lsp.config("wgsl_analyzer").enable()
--vim.lsp.config("pyright").enable()

-- html
local html_capabilities = vim.lsp.protocol.make_client_capabilities()
html_capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config("html", {
	capabilities = html_capabilities,
	filetypes = { "html", "templ", "htmldjango" },
})
-- css
vim.lsp.config("cssls", {
	capabilities = html_capabilities,
})

-- htmx
vim.lsp.config("htmx", {
	filetypes = { "html", "templ", "htmldjango" },
})

-- lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- rust
vim.lsp.config("rust_analyzer", {
	-- Server-specific settings. See `:help vim.lsp.config-setup`
	settings = {
		["rust-analyzer"] = {},
	},
})

-- vim.lsp.config("pyright", {
-- 	settings = {
-- 		mason = false,
-- 		autostart = true,
-- 		-- Dynamic root detection for buildout projects
-- 		root_dir = function(fname)
-- 			local util = require("lspconfig.util")
-- 
-- 			-- Always prioritize buildout.cfg with .vscode or .venv, even if further up
-- 			local current_dir = vim.fn.fnamemodify(fname, ":p:h")
-- 			while current_dir ~= "/" do
-- 				local buildout_cfg = current_dir .. "/buildout.cfg"
-- 				if vim.fn.filereadable(buildout_cfg) == 1 then
-- 					local has_vscode = vim.fn.isdirectory(current_dir .. "/.vscode") == 1
-- 					local has_venv = vim.fn.isdirectory(current_dir .. "/.venv") == 1
-- 					if has_vscode or has_venv then
-- 						return current_dir
-- 					end
-- 				end
-- 				current_dir = vim.fn.fnamemodify(current_dir, ":h")
-- 			end
-- 
-- 			-- Fallback to standard patterns
-- 			return util.root_pattern("pyproject.toml", "setup.py", ".git")(fname)
-- 		end,
-- 	},
-- })

--vim.lsp.enable({
--	"wgsl_analyzer",
--	"pyright",
--	"html",
--	"cssls",
--	"tailwindcss",
--	"ts_ls",
--	"htmx",
--	"lua_ls",
--	"rust_analyzer",
--})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
--
local conform_formatter = require("conform")
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			conform_formatter.format({ async = true })
			--vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
