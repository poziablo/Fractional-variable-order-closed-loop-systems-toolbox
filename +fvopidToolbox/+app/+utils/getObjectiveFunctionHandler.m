function objectiveFunctionHandler = getObjectiveFunctionHandler(objectiveFunctionSetupObject)
    switch objectiveFunctionSetupObject.ObjectiveFunctionType
        case fvopidToolbox.app.utils.ObjectiveFunctionSetup.ISE
            objectiveFunctionHandler = @(timeVector, errorVector, processOutputVector, setpointValue)fvopidToolbox.app.optimization.calculateISE(timeVector, errorVector, processOutputVector, setpointValue);
        case fvopidToolbox.app.utils.ObjectiveFunctionSetup.IAE
            objectiveFunctionHandler = @(timeVector, errorVector, processOutputVector, setpointValue)fvopidToolbox.app.optimization.calculateIAE(timeVector, errorVector, processOutputVector, setpointValue);    
        case fvopidToolbox.app.utils.ObjectiveFunctionSetup.ITAE
            objectiveFunctionHandler = @(timeVector, errorVector, processOutputVector, setpointValue)fvopidToolbox.app.optimization.calculateITAE(timeVector, errorVector, processOutputVector, setpointValue);        
        case fvopidToolbox.app.utils.ObjectiveFunctionSetup.ITSE
            objectiveFunctionHandler = @(timeVector, errorVector, processOutputVector, setpointValue)fvopidToolbox.app.optimization.calculateITSE(timeVector, errorVector, processOutputVector, setpointValue);           
        case fvopidToolbox.app.utils.ObjectiveFunctionSetup.SSE
            objectiveFunctionHandler = @(timeVector, errorVector, processOutputVector, setpointValue)fvopidToolbox.app.optimization.calculateSSE(timeVector, errorVector, processOutputVector, setpointValue);
        case fvopidToolbox.app.utils.ObjectiveFunctionSetup.SSTE
            objectiveFunctionHandler = @(timeVector, errorVector, processOutputVector, setpointValue)fvopidToolbox.app.optimization.calculateSSTE(timeVector, errorVector, processOutputVector, setpointValue);
        case fvopidToolbox.app.utils.ObjectiveFunctionSetup.SST2E
            objectiveFunctionHandler = @(timeVector, errorVector, processOutputVector, setpointValue)fvopidToolbox.app.optimization.calculateSST2E(timeVector, errorVector, processOutputVector, setpointValue);
        otherwise
            objectiveFunctionHandler = @(timeVector, errorVector, processOutputVector, setpointValue)eval(objectiveFunctionSetupObject.CustomObjectiveFunctionInvocation);
    end
end

