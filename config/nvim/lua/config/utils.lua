local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map a key to a lua callback
local function map_lua(mode, keys, action, options)
  if options == nil then
    options = {}
  end
  vim.api.nvim_set_keymap(mode, keys, "<cmd>lua " .. action .. "<cr>", options)
end

local function platform()
	local uname = io.popen('uname -s', 'r')
	local platform = uname:read('*a')
	return platform:gsub("\n", "")
end

return {map = map, map_lua = map_lua, platform = platform}
