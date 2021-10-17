function functionDefinition = getConstantOrderFunctionDefinition(functionName)
    functionDefinition = sprintf(['function y = ' functionName '(error, setpoint, currentTime, parametersVector, internalParametersVector)\n'...
        'y = parametersVector(1);']);
end

