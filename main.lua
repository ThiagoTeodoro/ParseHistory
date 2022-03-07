------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------


-- Import librarys
import "ParseHistory.Librarys";


--Main Call
SetupWindow();
LoadData();
AddCallback(ChatMonitor, "Received", ChatReceived);