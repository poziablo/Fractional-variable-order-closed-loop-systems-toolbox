function [ glVfobdValue, newABufferValue, newAvalue] = getGLFVOBDConv( x, order, xBuffer, aBuffer, previousAvalue, previousOrder, h)
    % The Grunwald-Letnikov variable-, fractional-order backward difference
    % of convolution type
    % The GL-VFOBD calculation function with k0 = 0

    k = length(xBuffer);
    if  order == previousOrder
        % Order was not changed - use old avalues vector to calculate next
        % avalue
        newAvalue = fvopidToolbox.glfvobd.getNextAvalue(order, previousAvalue, k);
        
        % Calculate a-vector
        newABuffer = [aBuffer newAvalue/(h^order)];
    else
        % Order was changed - calculate avalues vector
        newAvaluesBuffer = fvopidToolbox.glfvobd.getAvaluesVector(order, k);
        newAvalue = newAvaluesBuffer(end);
        
        % Calculate a-vector
        newABuffer = [aBuffer newAvalue/(h^order)];
    end

    % Calculate result
    xVector = [x xBuffer(end:-1:1)]';
    glVfobdValue = newABuffer * xVector;
    newABufferValue = newABuffer(end);
end