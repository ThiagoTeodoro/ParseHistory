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
   message = string.gsub(message, "<\\Select> says, 'Thou didst maintain a DPS of ", "")
   message = string.gsub(message, " over the last three minutes of our momentous conflict!'\n", "")
   local parseNumber = string.gsub(message, ",", "");
   --get final parse
   return parseNumber;
end

function RegisterDpsParseOnDatabase(Dps)
  NewParseData = {Dps, Turbine.Engine.GetDate()};
  table.insert(PARSES, NewParseData);
  SaveDataAndLoad(PARSES);
end
