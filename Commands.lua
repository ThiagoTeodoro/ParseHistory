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
		--On another version we will implments this
	elseif ( arguments == "Open" or arguments == "open") then
        OpenUi();
	elseif ( arguments == "Close" or arguments == "close") then
        CloseUi();
    end
end

------------------------------------------------------------------------------------------
-- Add the sahell command --
------------------------------------------------------------------------------------------
Turbine.Shell.AddCommand( "Parse;ParseHistory", ParseHistoryCommands );