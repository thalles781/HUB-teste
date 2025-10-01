-- DaviObfuscator Pro v2.0
-- Generated: 29/09/2025, 15:48:26
-- Protection Level: Maximum Security
-- Anti-Debug & Anti-Analysis Protection

local function decode_davimDM7XW78nx(hex)
    local result = {}
    local chars = "0123456789abcdef"
    
    -- Anti-debug check
    if getfenv == nil then
        error("Unsupported environment", 0)
    end
    
    for i = 1, #hex, 2 do
        local byte_str = hex:sub(i, i + 1)
        local byte_val = tonumber(byte_str, 16)
        if byte_val then
            table.insert(result, string.char(byte_val))
        end
    end
    
    return table.concat(result)
end

-- Execute protected code
local success, err = pcall(function()
    loadstring(decode_davimDM7XW78nx(""))()
end)

if not success then
    warn("Protection system active")
end