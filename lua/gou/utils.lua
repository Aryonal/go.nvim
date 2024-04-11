local M = {}

---Merge two tables into one.
---If elements in a and b share the same key, value from b will overwrite value from a.
---If elements in only in a, adopt it,
---If elements appear only in b, it is dropped,
---@param a table: the first table to merge.
---@param b table: the second table to merge.
---@return table: the merged table.
function M.merge_opts(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then
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
