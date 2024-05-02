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

    if type(opts.test_flag) == "string" and opts.test_flag ~= "" then
        args = vim.list_extend(args, { opts.test_flag })
    end
    if type(opts.test_flag) == "table" and opts.test_flag ~= {} then
        args = vim.list_extend(args, opts.test_flag)
    end

    if func_name ~= "" then
        local target = func_name
        if case_name ~= "" then
            target = func_name .. "/" .. case_name
        end
        args = vim.list_extend(args, { "-run", target })
    end

    args = vim.list_extend(args, { pkg_path })

    print(table.concat(vim.list_extend({ cmd, }, args), " "))
    print("...")

    if not opts.async then
        vim.notify(vim.fn.system(vim.list_extend({ cmd, }, args)))
    else
        local Job = require("plenary.job")
        Job:new({
            command = cmd,
            args = args,
            cwd = vim.fn.getcwd(),
            on_stdout = function(err, data)
                print(err)
                print(data)
            end,
        }):start()
    end
end

return M
