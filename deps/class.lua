local module = {}
local ClassList = {}
module.__index = module

module.new = function(name, structure, tab)
    local Pretable = structure
    if Pretable["Name"] then
        Pretable["Name"] = nil
    end
    Pretable["Name"] = name
    
    if tab then
        table.insert(tab, Pretable)
    else
        table.insert(ClassList, Pretable)
    end

    return Pretable
end

return module