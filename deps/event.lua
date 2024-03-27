local class = require("./class")
local module = {}

local function checkevent(list, name)
    for i, v in pairs(list["Events"]) do
        if v["Name"] == name then
            return v
        end
    end

    return nil
end

module.new = function(signal, name)
    local list = checkevent(signal, name)

    if list then
        print("list '"..name.."' already exists!")
        return nil
    end

    if not signal["Events"] then
        signal["Events"] = {}
    end

    local newEvent = class.new(name, {}, signal["Events"])

    if not newEvent["Callbacks"] then
        newEvent["Callbacks"] = {}
    end

    newEvent.OnFire = function(callback)
        if type(callback) ~= "function" then
            print("'callback' Parameter expected type = 'function'")
            return
        end

        newEvent["Callbacks"][#newEvent["Callbacks"]+1] = callback
    end

    newEvent.Fire = function(self, password, ...)
        if not self then
            return nil
        end

        if signal["Password"] and signal["Password"] == password then
            for _, k in pairs(newEvent["Callbacks"]) do
                if type(k) == "function" then
                    k(...)
                end
            end
        elseif not signal["Password"] then
            for _, k in pairs(newEvent["Callbacks"]) do
                if type(k) == "function" then
                    k(...)
                end
            end
        end
    end

    return newEvent
end

module.find = function(signal, name)
    local list = checkevent(signal, name)

    return list
end

return module