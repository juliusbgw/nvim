require("devcontainer").setup({
	attach_mounts = {
		neovim_config = {
			enabled = true,
			options = { "readonly" },
		},
		neovim_state = {
			enabled = false,
		},
	},
	autocommands = {
		-- can be set to true to automatically start containers when devcontainer.json is available
		init = true,
		-- can be set to true to automatically restart containers when devcontainer.json file is updated
		update = true,
	},
})
