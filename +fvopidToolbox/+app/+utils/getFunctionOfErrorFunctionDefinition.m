function functionDefinition = getFunctionOfErrorFunctionDefinition(functionName, userErrorToSetpointRatio)
    functionArray = ['function y = ' functionName '(error, setpoint, currentTime, parametersVector, internalParametersVector)\n'];
    if userErrorToSetpointRatio
        functionArray = [functionArray 'errorArgument = error/setpoint;\n'];
    else
        functionArray = [functionArray 'errorArgument = error;\n'];
    end
    functionArray = [functionArray 'y = fvopidToolbox.utils.getOrderValue(errorArgument, internalParametersVector, parametersVector);'];
    
    functionDefinition = sprintf(functionArray);
end

