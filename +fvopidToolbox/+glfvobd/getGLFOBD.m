function [ glVfobdValue, newAvaluesBuffer] = getGLFOBD( x, order, xBuffer, aValuesBuffer, denominatorValue)
    % The Grunwald-Letnikov fractional-order backward difference
    % The GL-FOBD calculation function with k0 = 0
    k = length(xBuffer);

    previousAvalue = aValuesBuffer(end);
    aValue = fvopidToolbox.glfvobd.getNextAvalue(order, previousAvalue, k);
    newAvaluesBuffer = [aValuesBuffer aValue];

    % Calculate result
    xVector = [x xBuffer(end:-1:1)]';
    glVfobdValue = newAvaluesBuffer * xVector / denominatorValue; 
end