-- Include CallBack for Monitors
AddCallback(ChatMonitor, "Received", DummyMonitor);
AddCallback(ChatMonitor, "Received", BossesMonitor);
AddCallback(PlayerMonitor,"InCombatChanged",function()

	local inCombat = PlayerMonitor:IsInCombat();

	if inCombat == true then
		--Turbine.Shell.WriteLine("Parse Monitoring has begun.")        
        CombateStart = Turbine.Engine.GetGameTime();
        Battle = {};
	end

    if inCombat == false then

		CalculateBosses();
	end
end);