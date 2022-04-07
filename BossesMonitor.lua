------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

BossesMonitor = function(f, args)

  ParseBossesMonitoring(args);
end

function ParseBossesMonitoring(args)	

	local line = "";
	if(args.Message ~= nil) then
		line = string.gsub(string.gsub(args.Message,"<rgb=#......>(.*)</rgb>","%1"),"^%s*(.-)%s*$", "%1");
	end

 	--Combat data
	if(args.ChatType == Turbine.ChatType.PlayerCombat or args.ChatType == Turbine.ChatType.DEATH or args.ChatType == Turbine.ChatType.EnemyCombat) then		

		local initiatorName,avoidAndCrit,skillName,targetNameAmountAndType = string.match(line,"^(.*) scored a (.*)hit(.*) on (.*)%.$");	

		if(targetNameAmountAndType ~= nil) then

			local targetName,amount,dmgType,moralePower = string.match(targetNameAmountAndType, "^(.*) for ([%d,]*) (.*)damage to (.*)$");

			if(targetName ~= nil and amount ~= nil) then

				-- Targe is a Boss Targe Monitor?
				if(has_value(Boss, string.gsub(targetName, "the ", ""))) then

					targetName =  string.gsub(targetName,"^[Tt]he ","");
					local ammoutNumber = string.gsub(amount, ",", "");						

					if Battle[targetName] == nil then
						Battle[targetName] = {tonumber(ammoutNumber)};
					else
						Battle[targetName] = {Battle[targetName][1] + tonumber(ammoutNumber)};
					end
				end
			end
		end
	end

	IdentifyEndOfBattle(line);
end

function IdentifyEndOfBattle(line)

	local DieLineRecived = string.match(line,"^.* defeated (.*)%.$");
	if (DieLineRecived ~= nil) then
		local whoDie = string.gsub(DieLineRecived,"^[Tt]he ","");
	   	RegisterKillOrDeath(whoDie);
	end

	local DieLineRecived = string.match(line,"^(.*) died%.$");
	if (DieLineRecived ~= nil) then
	   	local whoDie = string.gsub(DieLineRecived,"^[Tt]he ","");
		RegisterKillOrDeath(whoDie);
	end

	local DieLineRecived = string.match(line,"^(.*) has been defeated%.$");
	if (DieLineRecived ~= nil) then
		local whoDie = string.gsub(DieLineRecived,"^[Tt]he ","");
		RegisterKillOrDeath(whoDie);
	end

	local DieLineRecived = string.match(line,"^Your mighty blow topples (.*)%.$");	 
	if (DieLineRecived ~= nil) then
		local whoDie = string.gsub(DieLineRecived,"^[Tt]he ","");
		RegisterKillOrDeath(whoDie);
	end

	local DieLineRecived = string.match(line,"^You have been incapacitated by misadventure%.$");
	if (DieLineRecived ~= nil) then
		RegisterKillOrDeath(Event.MecOrEnvOrKilled);
	end

	local DieLineRecived = string.match(line,"^.* incapacitated you%.$");
	if (DieLineRecived ~= nil) then		
		RegisterKillOrDeath(Event.MecOrEnvOrKilled)
	end
end

function RegisterKillOrDeath(whoDie)

	if(has_value(Boss, string.gsub(whoDie, "the ", ""))) then
		if (whoDie ~= Event.MecOrEnvOrKilled and Battle[whoDie] ~= nil) then
			Battle[whoDie] = {Battle[whoDie][1], Turbine.Engine.GetGameTime()};
		elseif (whoDie == Event.MecOrEnvOrKilled) then
			for key, value in pairs(Battle) do
				if(value[2] == nil) then
					Battle.key = {value[1], Turbine.Engine.GetGameTime()};
				end
			end
		end
	end
end

function RegisterAndSaveParseMadOnBosses(register, boss)

	if (tonumber(register[1]) == nil or register[1] == 0 or register[2] == 0 or register[2] == nil or register[3] == 0 or register[3] == nil) then
		return
	else
		NewParseData = {boss, register[1], register[2], register[3]};
		table.insert(BossParseHistory, NewParseData);
		SaveData(BossParseHistory, "ParseHistory_Boss", function ()
			LoadData("ParseHistory_Boss", function (dataLoaded)
				if(dataLoaded ~= nil) then
					-- Update PARSES global variable, to preserve old data.
					BossParseHistory = dataLoaded;
					-- Function responsable for render data on window.
					ShowBossParses(BossParseHistory);
					Turbine.Shell.WriteLine("New Boss Parser Registered.")
				end
			end);
		end);
	end
end

function CalculateBosses()

	--Turbine.Shell.WriteLine("Parse Monitoring has begun.")
	CombateEnd = Turbine.Engine.GetGameTime();

	if(Battle ~= nil) then

		for key, value in pairs(Battle) do            
			if(value[2] == nil) then
				Battle[key] = {value[1], CombateEnd};                
			end
		end

		for key, value in pairs(Battle) do        
			if(key ~= nil and value[1] ~= nil and value[2] ~= nil) then    				
				dataToSave = {value[1]/(value[2] - CombateStart), value[2] - CombateStart, value[1]}
				RegisterAndSaveParseMadOnBosses(dataToSave, key);
				--Turbine.Shell.WriteLine(">>"..key.." Damage Causado "..FormatPerSecondNumber(value[1]).." Tempo "..value[2] - CombateStart.." DPS "..FormatPerSecondNumber(value[1]/(value[2] - CombateStart)));
			end
		end
	end
end

function CleanBossesParse()
	SaveData({}, "ParseHistory_Boss", function ()
		LoadData("ParseHistory_Boss", function (dataLoaded)
			if(dataLoaded ~= nil) then
				-- Update PARSES global variable, to preserve old data.
				BossParseHistory = dataLoaded;
				-- Function responsable for render data on window.
				ShowBossParses(BossParseHistory);
				Turbine.Shell.WriteLine("All Parses for Bosses have been cleared.")
			end
		end);
	end);
end
