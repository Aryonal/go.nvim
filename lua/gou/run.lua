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

    local pkg_path = "./" .. require("gou.utils").crop(path, cwd)

    local args = {
        "go", "test",
    }

    if opts.test_flag ~= "" then
        args = vim.list_extend(args, { opts.test_flag })
    end

    if func_name ~= "" then
        local target = func_name
        if case_name ~= "" then
            target = func_name .. "/" .. case_name
        end
        args = vim.list_extend(args, { "-run", target })
    end

    args = vim.list_extend(args, { pkg_path })

    vim.notify(table.concat(args, " "))
    vim.notify("...") -- TODO: make it async

    vim.notify(vim.fn.system(args))
end

return M
