local class = require("./class")
local module = {}

module.new = function(tab)
    if type(tab) ~= "table" then
        print("'tab' Parameter expected type = 'table'")
        return nil
    end

    local newClass = class.new(tab["Name"], tab)

    if not tab["Events"] then
        tab["Events"] = {}
    end

    for i, v in pairs(tab["Events"]) do

        if not v["Callbacks"] then
            v["Callbacks"] = {}
        end

        v.OnFire = function(callback)
            if type(callback) ~= "function" then
                print("'callback' Parameter expected type = 'function'")
                return
            end

            v["Callbacks"][#v["Callbacks"]+1] = callback
        end

        v.Fire = function(self, password, ...)
            if not self then
                return nil
            end
    
            if tab["Password"] and tab["Password"] == password then
                for _, k in pairs(v["Callbacks"]) do
                    if type(k) == "function" then
                        k(...)
                    end
                end
            elseif not tab["Password"] then
                for _, k in pairs(v["Callbacks"]) do
                    if type(k) == "function" then
                        k(...)
                    end
                end
            end
        end
    end

    return newClass
end

return module