------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

-- Utils Functions

function FormateNumberForHumans(numberString)  
  return ConvertToNumberK(tonumber(numberString)).."K";
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

function ConvertToNumberK(number)
  return Round((number/1000), 1);
end

function Round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end