--
-- Faster Growing Tress FS25
--
-- # Author: DrXmL

-- # date:   13.05.2025
--

-- Define the growth speed factor (e.g., 0.5 = twice as fast, 2 = half speed)
local growthSpeedFactor = 0.5

-- Store reference to original loadTreeTypes function
local originalLoadTreeTypes = TreePlantManager.loadTreeTypes

-- Override loadTreeTypes to modify growthTimeHours
function TreePlantManager:loadTreeTypes(xmlFile, missionInfo, baseDirectory, isBaseType, customEnvironment)
    -- Call original function
    local result = originalLoadTreeTypes(self, xmlFile, missionInfo, baseDirectory, isBaseType, customEnvironment)
    
    -- Modify growth times for all registered tree types
    for _, treeType in ipairs(self.treeTypes) do
        if treeType.growthTimeHours ~= nil then
            -- Multiply growthTimeHours by the factor to speed up growth
            local newTime = treeType.growthTimeHours * growthSpeedFactor
            -- Prevent negative or zero growth time
            treeType.growthTimeHours = math.max(newTime, 0.1)
        end
    end
    
    return result
end