function u = fvopidTypeA(e, kp, ki, kd, vi, vd, h, N, saturationEnabled, saturationLimitLow, saturationLimitHigh)
    persistent inptuSignalBuffer
    persistent stepCounter
    persistent integralAvaluesBuffer
    persistent derivativeAvaluesBuffer
    persistent previousIntegralOrder
    persistent previousDerivativeOrder
    
    % Integral order has an opposite sign
    vi = -vi;
    
    % If persistent variables are empty then initialize them
    if isempty(inptuSignalBuffer) || isempty(stepCounter) ||...
        isempty(integralAvaluesBuffer) || isempty(derivativeAvaluesBuffer) ||...
            isempty(previousIntegralOrder) || isempty(previousDerivativeOrder)
        
        % Initialize input buffer
        inptuSignalBuffer = zeros(1, N);
        inptuSignalBuffer(1) = 1;
        
        % Initialize step counter
        stepCounter = 1;
        
        % Initialize avalues buffers
        integralAvaluesBuffer = zeros(1, N);
        integralAvaluesBuffer(1) = 1;
        derivativeAvaluesBuffer = zeros(1, N);
        derivativeAvaluesBuffer(1) = 1;
        
        % Initialize previous avalues orders
        previousIntegralOrder = 0;
        previousDerivativeOrder = 0;
    end
    
    % Calculate controller proportional part
    proportional = kp * e;
    
    % Calculate controller integral part
    [integralGlVfobdValue, newIntegralAvaluesBuffer] = fvopidToolbox.glfvobd.getGLFVOBDOptimized(e, vi,...
        inptuSignalBuffer(1:stepCounter), integralAvaluesBuffer(1:stepCounter), previousIntegralOrder, h);
    integral = ki * integralGlVfobdValue;
    
    % Calculate controller derivative part
    [derivativeGlVfobdValue, newDerivativeAvaluesBuffer] = fvopidToolbox.glfvobd.getGLFVOBDOptimized(e, vd,...
        inptuSignalBuffer(1:stepCounter), derivativeAvaluesBuffer(1:stepCounter), previousDerivativeOrder, h);
    derivative = kd * derivativeGlVfobdValue; 
    
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
    
    if vi == previousIntegralOrder
        integralAvaluesBuffer(stepCounter) = newIntegralAvaluesBuffer(end);
    else    
        integralAvaluesBuffer(1:stepCounter) = newIntegralAvaluesBuffer;
    end
    
        
    if vd == previousDerivativeOrder
        derivativeAvaluesBuffer(stepCounter) = newDerivativeAvaluesBuffer(end);
    else    
        derivativeAvaluesBuffer(1:stepCounter) = newDerivativeAvaluesBuffer;
    end
    
    previousIntegralOrder = vi;
    previousDerivativeOrder = vd;
end

