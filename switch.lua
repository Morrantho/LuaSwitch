local tonum  = tonumber

function tobool(b)
    if b == "true" then
        return true
    elseif b == "false" then
        return false
    elseif b == 1 then
        return 1
    elseif b == 0 then
        return 0
    end
    
    return nil
end

local switch = {}
local mt     = {}
local mt2    = {}

function mt2.__call(t,k)
    switch[t[1]] = k

    for a,b in pairs(switch[t[1]]) do
        if a == t[1] then
            b()
            break
        else
            if a == "default" then
                b()
            end
        end
    end

    switch[t[1]] = nil
    t = nil
    k = nil
end

function mt.__call(t,k)
    if not t[k] then
        local key
        
        if tonum(k) then
            key = tonum(k)
        elseif tobool(k) then
            key = tobool(k)
        end
        
        t[k] = {key}
        setmetatable(t[k],mt2)

        return t[k]
    end
end
setmetatable(switch,mt)

local inp = io.read()

switch(inp) { -- Example
    function()
        print("You input 1.")
    end,

    function()
        print("You input 2.")
    end,
    
    [123] = function() 
        print("You input 123.")
    end,
    
    default = function()
        print("Your input didnt match any options.")
    end
}
