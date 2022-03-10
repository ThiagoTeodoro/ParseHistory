------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

--Data Storage functions
function SaveData(dataToSave, scope, callback)
    Turbine.PluginData.Save(Turbine.DataScope.Character, scope, dataToSave, callback);
end

function LoadData(scope, callback)
    Turbine.PluginData.Load(Turbine.DataScope.Character, scope, callback);        
end