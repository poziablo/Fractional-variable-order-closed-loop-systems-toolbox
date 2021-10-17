function [nextAvalue] = getNextAvalue(order, previousAvalue, stepCounter)
    nextAvalue = previousAvalue * (1 - ((order + 1)/stepCounter));
end

