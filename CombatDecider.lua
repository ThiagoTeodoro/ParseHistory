--Combat state changes
AddCallback(PlayerMonitor,"InCombatChanged",function()

	local inCombat = PlayerMonitor:IsInCombat();

	if inCombat == true then
		Turbine.Shell.WriteLine("Parse Monitoring has begun.")

		AddCallback(ChatMonitor, "Received", DummyMonitor);
	end

	if inCombat == false then
		Turbine.Shell.WriteLine("Parse Monitoring ended.")
		
		RemoveCallback(ChatMonitor, "Received", DummyMonitor);
	end
end);
