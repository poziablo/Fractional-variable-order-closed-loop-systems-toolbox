function u = fopid(e, kp, ki, kd, vi, vd, h, N, saturationEnabled, saturationLimitLow, saturationLimitHigh)
    persistent inptuSignalBuffer
    persistent stepCounter
    persistent integralAvaluesBuffer
    persistent derivativeAvaluesBuffer
    persistent integralDenominator
    persistent derivativeDenominator
    
    % Integral order has an opposite sign
    vi = -vi;
    
    % If persistent variables are empty then initialize them
    if isempty(inptuSignalBuffer) || isempty(stepCounter) ||...
        isempty(integralAvaluesBuffer) || isempty(derivativeAvaluesBuffer) ||...
        isempty(integralDenominator) || isempty(derivativeDenominator)
        
        % Initialize input buffer
        inptuSignalBuffer = zeros(1, N);
        inptuSignalBuffer(1) = 0;
        
        % Initialize step counter
        stepCounter = 1;
        
        % Initialize avalues buffers
        integralAvaluesBuffer = zeros(1, N);
        integralAvaluesBuffer(1) = 1;
        derivativeAvaluesBuffer = zeros(1, N);
        derivativeAvaluesBuffer(1) = 1;
        
        % Initialize denominators
        integralDenominator = h^vi;
        derivativeDenominator = h^vd;
    end
    
    % Calculate controller proportional part
    proportional = kp * e;
    
    % Calculate controller integral part
    [integralGlfobdValue, newIntegralAvaluesBuffer] = fvopidToolbox.glfvobd.getGLFOBD(e, vi, inptuSignalBuffer(1:stepCounter), integralAvaluesBuffer(1:stepCounter), integralDenominator);
    integral = ki * integralGlfobdValue;
    
    % Calculate controller derivative part
    [derivativeGlfobdValue, newDerivativeAvaluesBuffer] = fvopidToolbox.glfvobd.getGLFOBD(e, vd, inptuSignalBuffer(1:stepCounter), derivativeAvaluesBuffer(1:stepCounter), derivativeDenominator);
    derivative = kd * derivativeGlfobdValue; 
    
    % Calculate controller response
    u = proportional + integral + derivative;
    
    % Incorporate saturation
    if saturationEnabled ~= 0
        if u > saturationLimitHigh
            u = saturationLimitHigh;
        elseif u < saturationLimitLow
            u = saturationLimitLow;
        end
    end
    
    % Update persistent variables
    stepCounter = stepCounter + 1;
    inptuSignalBuffer(stepCounter) = e;
    
    integralAvaluesBuffer(stepCounter) = newIntegralAvaluesBuffer(end);
    derivativeAvaluesBuffer(stepCounter) = newDerivativeAvaluesBuffer(end);
end

