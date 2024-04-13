local M = {}

---Merge two tables into one.
---If a key appears in both a and b, value from b will overwrite a,
---If a key appears only in a, adopt its value,
---If a key appears only in b, or value is nil, drop it,
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

return M
