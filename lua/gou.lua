local M = {}

local default_opts = {
    run = {
        enabled = true,
        async = true,
        test_flag = "",
    },
    gotests = {
        enabled = true,
        async = true,
        named = true,
        template_dir = "",
    }
}

local function setup_gotests(opts)
    vim.api.nvim_create_user_command(
        "GoTestsGenFunc",
        function()
            local ts = require("gou.ts")

            local last_func_node = ts.get_last_parent_func_node()
            local func_name = ts.get_function_node_name(last_func_node)

            require("gou.gotests").gotests(opts.gotests, func_name)
        end,
        { desc = "Generate tests for current function" })

    vim.api.nvim_create_user_command(
        "GoTestsGen",
        function()
            require("gou.gotests").gotests(opts.gotests, "")
        end,
        { desc = "Generate tests for current file" })
end

local function setup_run(opts)
    vim.api.nvim_create_user_command(
        "GoTestFunc",
        function(args)
            local ts = require("gou.ts")

            local last_func_node = ts.get_last_parent_func_node()
            local func_name = ts.get_function_node_name(last_func_node)

            local case_name = args.args

            require("gou.run").test(opts.run, func_name, case_name)
        end,
        { desc = "Run tests for current function, or a test case if specified", nargs = "*" })

    vim.api.nvim_create_user_command(
        "GoTestPkg",
        function()
            require("gou.run").test(opts.run, "", "")
        end,
        { desc = "Run tests for current package" })
end

function M.setup(opts)
    opts = opts or {}
    opts = require("gou.utils").merge_opts(default_opts, opts)

    if opts.gotests.enabled then
        setup_gotests(opts)
    end

    if opts.run.enabled then
        setup_run(opts)
    end
end

return M
