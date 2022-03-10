------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------


-- Import librarys
import "ParseHistory.Librarys";


--Main Call
SetupWindowForDummyParse();
LoadData("ParseHistory_Dummy", function (dataLoaded)
    if(dataLoaded ~= nil) then
        -- Update PARSES global variable, to preserve old data.
        DummyParseHistory = dataLoaded;
        -- Function responsable for render data on window.
        ShowDummyParses(DummyParseHistory);
    end
end);

