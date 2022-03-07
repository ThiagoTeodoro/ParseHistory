------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

-- Call Back Function
function AddCallback(object, event, callback)
    if (object[event] == nil) then
      object[event] = callback;
    else
      if (type(object[event]) == "table") then
        table.insert(object[event], callback);
      else
        object[event] = {object[event], callback};
      end
    end
    return callback;
end