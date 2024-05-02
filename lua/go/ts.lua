---@diagnostic disable: undefined-doc-name, return-type-mismatch
local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")

---check if node type is a function or method
---@param typ string: node type string
---@return boolean: true if type is a function or method
local function is_function(typ)
    return typ == "function_declaration" or typ == "method_declaration"
end

---TODO: confirm ts parse is available in current buffer

---get the first parent function node or nil, current node is included
---@return TSNode: function node
function M.get_first_parent_func_node()
    local node = ts_utils.get_node_at_cursor()
    if node then
        local parent = node
        while parent do
            if is_function(parent:type()) then
                return parent
            end
            parent = parent:parent()
        end
    end
    return nil
end

---get the last parent function node or nil, current node is included
---@return TSNode: function node
function M.get_last_parent_func_node()
    local node = ts_utils.get_node_at_cursor()
    if node then
        local parent = node
        local last_func = nil
        while parent do
            if is_function(parent:type()) then
                last_func = parent
            end
            parent = parent:parent()
        end
        return last_func
    end
    return nil
end

---get the current function node or nil
---@param node TSNode: function node
---@return string: function name
function M.get_function_node_name(node)
    if node == nil then
        return ""
    end
    ---@diagnostic disable-next-line: undefined-field
    local name_node = node:field("name")[1]
    return vim.treesitter.get_node_text(name_node, 0)
end

return M
