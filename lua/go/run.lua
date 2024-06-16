local M = {}

local function is_go_test_func(func_name)
    local go_test_func_pattern = {
        "^Test"
    }

    for _, pattern in ipairs(go_test_func_pattern) do
        if string.match(func_name, pattern) then
            return true
        end
    end
end

function M.test(opts, func_name, case_name)
    if func_name ~= "" and not is_go_test_func(func_name) then
        vim.notify("Not a go test function")
        return
    end
    local cwd = vim.fn.getcwd() .. "/"
    local path = vim.fn.expand("%:p:h")

    local pkg_path = "./" .. require("go.utils").crop(path, cwd)

    local cmd = "go"
    local args = {
        "test",
    }

    if type(opts.run.test_flag) == "string" and opts.run.test_flag ~= "" then
        args = vim.list_extend(args, { opts.run.test_flag })
    end
    if type(opts.run.test_flag) == "table" and opts.run.test_flag ~= {} then
        args = vim.list_extend(args, opts.run.test_flag)
    end

    if func_name ~= "" then
        local target = func_name
        if case_name ~= "" then
            target = func_name .. "/" .. case_name
        end
        args = vim.list_extend(args, { "-run", target })
    end

    args = vim.list_extend(args, { pkg_path })

    local mode = opts.run.mode or opts.mode
    if not mode then
        if opts.run.async == true then
            mode = "async"
        end
    end

    require("go.utils").run_cmd(mode, cmd, args)
end

return M
