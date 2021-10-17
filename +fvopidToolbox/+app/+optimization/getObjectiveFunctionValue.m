function objectiveFunctionValue = getObjectiveFunctionValue(modelName, numberOfIntegralOrderParameters, simulationTimeString,...
    setpointValue, objectiveFunction, parametersVector)

    % I am not reusing exactly the same functionality with classes etc.
    % just to make this part of the code as short/fast as possible because
    % it will be executed many times. Uses of proper classes as it was done
    % for step response could increase code clarity, but I am not exactly
    % sure the the impact on the performance.
    controllerBlockName = '/GL FVOPID';
    integralParametersBlock = '/constant_integralParametersVector';
    derivativeParametersBlock = '/constant_derivativeParametersVector';
    
    set_param([modelName controllerBlockName], 'kp', num2str(parametersVector(1)));
    set_param([modelName controllerBlockName], 'ki', num2str(parametersVector(2)));
    set_param([modelName controllerBlockName], 'kd', num2str(parametersVector(3)));
    
    integralParametersVector = parametersVector(4:3 + numberOfIntegralOrderParameters);
    set_param([modelName integralParametersBlock], 'Value', ['[' num2str(integralParametersVector) ']']);
    derivativeParametersVector = parametersVector(4 + numberOfIntegralOrderParameters:end);
    set_param([modelName derivativeParametersBlock], 'Value', ['[' num2str(derivativeParametersVector) ']']);
    
    try
        % Run simulation
        simulationResult = sim(modelName, 'StartTime','0', 'StopTime', simulationTimeString);

        % Get result data - error data has index {4}, while process output has
        % index {1} (both outputs should have the sime time vectors)
        simulationData = simulationResult.yout;
        objectiveFunctionValue = objectiveFunction(simulationData{4}.Values.Time, simulationData{4}.Values.Data,...
            simulationData{1}.Values.Data, setpointValue);
    catch Ex
        % The error occured during simulation - probably caused by infinite
        % output value
        objectiveFunctionValue = Inf;
    end
end

