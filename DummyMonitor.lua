------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

DummyMonitor = function(f, args)

  ParseDummyMnitoring(args);
end

function ParseDummyMnitoring(args)

  if(args.ChatType == Turbine.ChatType.Say) then

    local message = args.Message;
    if string.find(message, "DPS target dummy<\\Select> says, 'Thou didst maintain a DPS of ", 1 , true) ~= nil then

      Turbine.Shell.WriteLine("New parse identified.");
      local Dps = SearchDpsNumberOnDummy(message);
      RegisterAndSaveParseMadOnDummy(Dps);
    end
  end
end

function SearchDpsNumberOnDummy(message)
   --cleaning up message.
   message = string.sub(message, string.find(message, "<\\Select>", 1 , true), -1);
   message = string.gsub(message, "<\\Select> says, 'Thou didst maintain a DPS of ", "")
   message = string.gsub(message, " over the last three minutes of our momentous conflict!'\n", "")
   local parseNumber = string.gsub(message, ",", "");
   --get final parse
   return parseNumber;
end

function RegisterAndSaveParseMadOnDummy(Dps)
  NewParseData = {Dps, Turbine.Engine.GetDate()};
  table.insert(DummyParseHistory, NewParseData);
  SaveData(DummyParseHistory, "ParseHistory_Dummy", function ()
    LoadData("ParseHistory_Dummy", function (dataLoaded)
      if(dataLoaded ~= nil) then
        -- Update PARSES global variable, to preserve old data.
        DummyParseHistory = dataLoaded;
        -- Function responsable for render data on window.
        ShowDummyParses(DummyParseHistory);
      end
    end);
  end);
end
