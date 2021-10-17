function u = fvopidConv(e, kp, ki, kd, vi, vd, h, N, saturationEnabled, saturationLimitLow, saturationLimitHigh)
    persistent inptuSignalBuffer
    persistent stepCounter
    persistent integralABuffer
    persistent derivativeABuffer
    persistent previousIntegralOrder
    persistent previousDerivativeOrder
    persistent previousIntegralAValue
    persistent previousDerivativeAValue
    
    % Integral order has an opposite sign
    vi = -vi;
    
    % If persistent variables are empty then initialize them
    if isempty(inptuSignalBuffer) || isempty(stepCounter) ||...
        isempty(integralABuffer) || isempty(derivativeABuffer) ||...
            isempty(previousIntegralOrder) || isempty(previousDerivativeOrder) ||...
                isempty(previousIntegralAValue) || isempty(previousDerivativeAValue)
        
        % Initialize input buffer
        inptuSignalBuffer = zeros(1, N);
        inptuSignalBuffer(1) = 1;
        
        % Initialize step counter
        stepCounter = 1;
        
        % Initialize avalues buffers
        integralABuffer = zeros(1, N);
        integralABuffer(1) = 1/(h^vi);
        derivativeABuffer = zeros(1, N);
        derivativeABuffer(1) = 1/(h^vd);
        
        % Initialize previous orders
        previousIntegralOrder = 0;
        previousDerivativeOrder = 0;
        
        % Initialize previous a values
        previousIntegralAValue = 1;
        previousDerivativeAValue = 1;
    end
    
    % Calculate controller proportional part
    proportional = kp * e;
    
    % Calculate controller integral part
    [integralGlVfobdValue, newIntegralABufferValue, newIntegralAvalue] = fvopidToolbox.glfvobd.getGLFVOBDConv(e, vi,...
        inptuSignalBuffer(1:stepCounter), integralABuffer(1:stepCounter), previousIntegralAValue, previousIntegralOrder, h);
    integral = ki * integralGlVfobdValue;
    
    % Calculate controller derivative part
    [derivativeGlVfobdValue, newDerivativeABufferValue, newDerivativeAvalue] = fvopidToolbox.glfvobd.getGLFVOBDConv(e, vd,...
        inptuSignalBuffer(1:stepCounter), derivativeABuffer(1:stepCounter), previousDerivativeAValue, previousDerivativeOrder, h);
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
    integralABuffer(stepCounter) = newIntegralABufferValue;
    derivativeABuffer(stepCounter) = newDerivativeABufferValue;
    previousIntegralOrder = vi;
    previousDerivativeOrder = vd;
    previousIntegralAValue = newIntegralAvalue;
    previousDerivativeAValue = newDerivativeAvalue;
end

