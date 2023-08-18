return {
	{
		"terrortylor/nvim-comment",
		name = "nvim_comment",
		dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"},
		keys = {
			{
				"<C-/>",
				":CommentToggle<CR>",
				desc = "Toggle comment for line"
			},
			{
				"<C-/>",
				":'<,'>CommentToggle<CR>",
				mode = "v",
				desc = "Toggle comment for line"
			}
		},
		opts = {
			hook = function()
				-- require('ts_context_commentstring.internal').update_commentstring({})
			end
		}
	}
}
