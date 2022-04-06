------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

ParseHistoryCommands = Turbine.ShellCommand();
------------------------------------------------------------------------------------------
-- commands
------------------------------------------------------------------------------------------
function ParseHistoryCommands:Execute( command, arguments )
	------------------------------------------------------------------------------------------
	-- Open and Close Window
	------------------------------------------------------------------------------------------
	if ( arguments == "help" ) then
		Turbine.Shell.WriteLine("/Parse open dummy");
		Turbine.Shell.WriteLine("/Parse open bosses");	
		Turbine.Shell.WriteLine("/Parse clean bosses");	
		Turbine.Shell.WriteLine("/Parse clean dummy");	
	elseif ( string.lower(arguments) == "open") then
        Turbine.Shell.WriteLine("We change this command type /Parse open dummy now.");
	elseif ( string.lower(arguments) == "open dummy") then
        OpenWindowDummy();
	elseif ( string.lower(arguments) == "open bosses") then
		OpenWindowBoss();
	elseif ( string.lower(arguments) == "clean bosses") then
		CleanBossesParse();
	elseif ( string.lower(arguments) == "clean dummy") then
		CleanDummyParse();
	end
end

------------------------------------------------------------------------------------------
-- Add the sahell command --
------------------------------------------------------------------------------------------
Turbine.Shell.AddCommand( "parse,Parse;ParseHistory", ParseHistoryCommands );