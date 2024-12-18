return {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	config = function()
		vim.keymap.set("i", "<m-]>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<m-[>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true })
	end,
}
