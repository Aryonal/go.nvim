local M = {}

local default_opts = {
    gotests = {
        named = true,
        template_dir = "",
    }
}

function M.setup(opts)
    opts = opts or {}
    opts = require("gou.utils").merge_tbl(default_opts, opts)

    vim.api.nvim_create_user_command(
        "GoTestsFunc",
        function()
            local ts = require("gou.ts")

            local last_func_node = ts.get_last_parent_func_node()
            local func_name = ts.get_function_node_name(last_func_node)

            require("gou.gotests").gotests(opts.gotests, func_name)
        end,
        { desc = "Generate tests for current function" })

    vim.api.nvim_create_user_command(
        "GoTests",
        function()
            require("gou.gotests").gotests(opts.gotests, "")
        end,
        { desc = "Generate tests for current file" })
end

return M
