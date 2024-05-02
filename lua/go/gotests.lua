local M = {}

function M.gotests(opts, func_name)
    if vim.fn.executable("gotests") ~= 1 then
        vim.notify("gotests not found")
    end

    local cmd = "gotests"

    local args = {
        "-w",
    }

    if opts.named then
        table.insert(args, "-named")
    end

    if func_name ~= "" then
        args = vim.list_extend(args, { "-only", func_name })
    end

    if opts.template_dir ~= "" then
        local dir = vim.fn.expand(opts.template_dir)
        args = vim.list_extend(args, { "-template_dir", dir })
    end

    local path = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()
    path = require("utils.lua").crop(path, cwd)

    args = vim.list_extend(args, { "." .. path })

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
