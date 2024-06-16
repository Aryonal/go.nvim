local M = {}

function M.gotests(opts, func_name)
    if vim.fn.executable("gotests") ~= 1 then
        vim.notify("gotests not found")
    end

    local cmd = "gotests"

    local args = {
        "-w",
    }

    if opts.gotests.named then
        table.insert(args, "-named")
    end

    if func_name ~= "" then
        args = vim.list_extend(args, { "-only", func_name })
    end

    if opts.gotests.template_dir ~= "" then
        local dir = vim.fn.expand(opts.gotests.template_dir)
        args = vim.list_extend(args, { "-template_dir", dir })
    end

    local path = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()
    path = require("utils.lua").crop(path, cwd)

    args = vim.list_extend(args, { "." .. path })

    local mode = opts.gotests.mode or opts.mode
    if not mode then
        if opts.gotests.async == true then
            mode = "async"
        end
    end

    require("go.utils").run_cmd(mode, cmd, args)
end

return M
