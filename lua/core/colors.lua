-- colorscheme settings to be present here
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	term_colors = true,
	no_italic = false,
	no_bold = false,
	no_underline = false,
	styles = {
		comments = {},
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}
	},
})

vim.cmd.colorscheme "catppuccin"
