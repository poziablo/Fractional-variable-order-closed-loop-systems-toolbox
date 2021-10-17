function [processTime, processOutput, integralTime, integralOrderOutput, derivativeTime, derivativeOrderOutput, errorTime, errorOutput, controllerOutputTime, controllerOutput] =...
    getPlantSystemResponse(closedLoopSystemSetupObject, controllerSetupObject, controllerParametersObject)
    
    % Initialize model
    modelName = fvopidToolbox.app.utils.initializeModel(closedLoopSystemSetupObject, controllerSetupObject);
    
    % Set controller parameters
    fvopidToolbox.app.utils.setModelControllerParameters(modelName, controllerParametersObject);
    
    % Run simulation
    simulationResult = sim(modelName, 'StartTime','0', 'StopTime', num2str(closedLoopSystemSetupObject.SimulationTime));

    % Get result data
    simulationData = simulationResult.yout;
    processOutput = simulationData{1}.Values.Data;
    processTime = simulationData{1}.Values.Time;
    integralOrderOutput = simulationData{2}.Values.Data;
    integralTime = simulationData{2}.Values.Time;
    derivativeOrderOutput = simulationData{3}.Values.Data;
    derivativeTime = simulationData{3}.Values.Time;
    errorOutput = simulationData{4}.Values.Data;
    errorTime = simulationData{4}.Values.Time;
    controllerOutput = simulationData{5}.Values.Data;
    controllerOutputTime = simulationData{5}.Values.Time;
    
    % Close system
    close_system(modelName, false);
end

