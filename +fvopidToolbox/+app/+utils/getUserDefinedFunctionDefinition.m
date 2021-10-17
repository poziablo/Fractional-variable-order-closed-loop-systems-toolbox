function functionDefinition = getUserDefinedFunctionDefinition(functionName, functionBody)
    functionDefinition = sprintf(['function y = ' functionName '(error, setpoint, currentTime, parametersVector, internalParametersVector)\n' functionBody]);
end

