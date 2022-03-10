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
	elseif ( string.lower(arguments) == "open") then
        Turbine.Shell.WriteLine("We change this command type /Parse open dummy now.");
	elseif ( string.lower(arguments) == "open dummy") then
        OpenWindowDummy();
	elseif ( string.lower(arguments) == "open bosses") then
				
	end
end

------------------------------------------------------------------------------------------
-- Add the sahell command --
------------------------------------------------------------------------------------------
Turbine.Shell.AddCommand( "parse,Parse;ParseHistory", ParseHistoryCommands );