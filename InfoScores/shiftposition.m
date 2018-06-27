function position=shiftposition(binned_position,shift_value)
%Takes in binned position values, and shifts them

if shift_value>=0
    position=vertcat(binned_position(shift_value+1:end),binned_position(1:shift_value));
else
    position=vertcat(binned_position(end-abs(shift_value):end),binned_position(1:end-abs(shift_value)-1));
end
