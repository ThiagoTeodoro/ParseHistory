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

function has_value (tab, val)
  for index, value in ipairs(tab) do
      if value == val then
          return true
      end
  end
  return false
end

function FormatNumber(number)

  number = Round(number);

	-- if the number is below 100,000 display it in full
	if (number < 100000) then
		return string.format("%d,%03d",number/1000,number%1000);
	end
	
	-- otherwise, for very large numbers, round them further (depending on the value)
	number = number/1000;
	local thousands = 1;
	while (number > 1000) do
		number = number/1000;
		thousands = thousands + 1;
		if (thousands > 3) then break end
	end
	
	return string.format("%#."..
		(number < 10 and 3 or (number < 100 and 2 or (number < 1000 and 1 or 0))).."f"..
		(thousands == 1 and "K" or (thousands == 2 and "M" or (thousands == 3 and "B" or "L.Trillion"))), 
    number
	);
end



function FormatPerSecondNumber(ps)

  local number = (ps + 0);

  -- if the number is less than 10,000 display the number (always) rounded to one decimal
  ps = Round(number,1);
  if (ps < 1000) then
    return string.format("%#.1f",ps);
  elseif (ps < 10000) then
    return string.format("%d,%05.1f",ps/1000,ps%1000);
  end

  -- display the number in the standard long format
  return FormatNumber(ps);
end