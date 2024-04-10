local M = {}

function M.gotests(opts, func_name)
    if vim.fn.executable("gotests") ~= 1 then
        vim.notify("gotests not found")
    end

    local args = {
        "gotests",
        "-w",
    }

    if opts.named then
        table.insert(args, "-named")
    end

    if func_name ~= "" then
        args = vim.list_extend(args, { "-only", func_name })
    end

    if opts.template_dir then
        args = vim.list_extend(args, { "-template_dir", opts.template_dir })
    end

    local path = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()
    path = require("utils.lua").crop(path, cwd)

    args = vim.list_extend(args, { "." .. path })

    vim.notify(table.concat(args, " "))
    vim.notify("...") -- TODO: make it async

    vim.notify(vim.fn.system(args))
end

return M
