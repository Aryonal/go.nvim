local M = {}

---DEPRECATED: use vim.tbl_deep_extend
---
---Merge two tables into one.
---If a key exists in both a and b, value from b will overwrite a,
---If a key exists only in a, adopt its value,
---If a key exists only in b, or value is nil, drop it,
---@param a table: the first table to merge.
---@param b table: the second table to merge.
---@return table: the merged table.
function M.merge_opts(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then
        if b ~= nil then
            return b
        end
        return a
    end

    local m = {}
    for k, _ in pairs(a) do
        local vv = M.merge_opts(a[k], b[k])
        m[k] = vv
    end

    return m
end

---crop string b from a,
-- e.g. crop("abcde", "abc") -> "de"
---@param a string
---@param b string
---@return string
function M.crop(a, b)
    local start_index = #b + 1
    local result = string.sub(a, start_index)
    return result
end

---open a terminal and feed it with commands
---@param cmd string: commands to feed into terminal
---@param args table: arguments for the command
---@param win_opts table: window options, see :h nvim_open_win
function M.open_term_with_cmd(cmd, args, win_opts)
    local bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_open_win(bufnr, true, win_opts)
    local channel_id = vim.fn.termopen(vim.o.shell)
    -- concat the command with arguments
    cmd = cmd .. " " .. table.concat(args, " ")
    vim.api.nvim_chan_send(channel_id, cmd)
end

---Run a command
---@param mode string: one of "terminal", "sync", "async"
---@param cmd string: the command to run
---@param args table: arguments for the command
function M.run_cmd(mode, cmd, args)
    if not (mode == "terminal" or mode == "sync" or mode == "async") then
        error("Invalid mode: " .. mode)
    end

    if mode == "terminal" then
        M.open_term_with_cmd(cmd, args, {
            split = "below",
            win = 0,
        })
        return
    end

    print(table.concat(vim.list_extend({ cmd, }, args), " "))
    print("...")

    if mode == "async" then
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
        return
    end
    vim.notify(vim.fn.system(vim.list_extend({ cmd, }, args)))
end

return M
