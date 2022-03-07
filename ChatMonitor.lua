------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

ChatMonitor = Turbine.Chat;

ChatReceived = function(f, args)

  ParseMnitoring(args);
  OpenWindowMonitoring(args);
end

function ParseMnitoring(args)

  if(args.ChatType == Turbine.ChatType.Say) then

    local message = args.Message;
    if string.find(message, "DPS target dummy<\\Select> says, 'Thou didst maintain a DPS of ", 1 , true) ~= nil then

      Turbine.Shell.WriteLine("New parse identified.");
      local Dps = SearchDpsParse(message);
      RegisterDpsParseOnDatabase(Dps);
    end
  end
end

function OpenWindowMonitoring(args)  
  if(args.ChatType == Turbine.ChatType.Say) then

    local message = args.Message;
    if string.find(message, "You say, 'Open ParseHistory'", 1 , true) ~= nil then
      OpenUi();
    end
  end
end

function SearchDpsParse(message)
   --cleaning up message.
   message = string.sub(message, string.find(message, "<\\Select>", 1 , true), -1);
   --get final parse
   return string.gsub(message, "%D+", "");
end

function RegisterDpsParseOnDatabase(Dps)
  NewParseData = {Dps, Turbine.Engine.GetDate()};
  table.insert(PARSES, NewParseData);
  SaveDataAndLoad(PARSES);
end
