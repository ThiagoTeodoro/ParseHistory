------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

-- Utils Functions

function FormateNumberForHumans(number)

    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)');

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,");

    -- reverse the int-string back remove an optional comma and put the 
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction;
end

function FormateDateForHumans(date)

    local Day = date['Day'];
    local Month = date['Month'];
    local Year =  date['Year'];
    local Hour =  date['Hour'];
    local Minute = date['Minute'];

    if(Day < 10)then
      Day = "0"..Day;
    end
    if(Month < 10)then
      Month = "0"..Month;
    end
    if (Hour < 10) then
      Hour = "0"..Hour;
    end
    if(Minute < 10)then
      Minute = "0"..Minute;
    end

    return Day.."/"..Month.."/"..Year.." "..Hour..":"..Minute;
end

function ReverseList(list)

    reverse = {};

    for i = #list, 1, -1 do
        table.insert(reverse, list[i]);
    end

    return reverse;
end