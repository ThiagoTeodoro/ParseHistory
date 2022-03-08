------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

--Data Storage functions
function SaveDataAndLoad(dataToSave)
    Turbine.PluginData.Save(Turbine.DataScope.Character, "ParseHistory_Dummy", dataToSave,
        function (status, message)
            LoadData();
        end
    );
end

function LoadData()
    Turbine.PluginData.Load(Turbine.DataScope.Character, "ParseHistory_Dummy",
        function(dataLoad)
            if(dataLoad ~= nil) then
                -- Update PARSES global variable, to preserve old data.
                PARSES = dataLoad;
                -- Function responsable for render data on window.
                ShowParses(PARSES);
            end
        end
    );
end