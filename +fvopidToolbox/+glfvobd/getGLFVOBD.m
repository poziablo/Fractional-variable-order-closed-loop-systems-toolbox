function [ glVfobdValue ] = getGLFVOBD( x, order, xBuffer)
%The Grunwald-Letnikov variable-, fractional-order backward difference
%   The GL-VFOBD calculation function with k0 = 0
    k = length(xBuffer);

    % Calculate vector 'a'
    a = fvopidToolbox.glfvobd.getAvaluesVector(order, k);
    
    % Calculate result
    xVector = [x xBuffer(end:-1:1)]';
    glVfobdValue = a * xVector; 
end
