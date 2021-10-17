function setModelController(modelName, controllerSetupObject)
    integralOrderFunctionName = 'integralOrderFunction';
    derivativeOrderFunctionName = 'derivativeOrderFunction';
    internalIntegralParametersBlock = '/constant_integralParametersVector_internal';
    internalDerivativeParametersBlock = '/constant_derivativeParametersVector_internal';
    
    switch controllerSetupObject.IntegralOrderType
        case fvopidToolbox.app.utils.ControllerSetup.CONSTANT_ORDER
             integralFunctionScript = fvopidToolbox.app.utils.getConstantOrderFunctionDefinition(integralOrderFunctionName);
        case fvopidToolbox.app.utils.ControllerSetup.FUNCTION_OF_ERROR
             integralFunctionScript = fvopidToolbox.app.utils.getFunctionOfErrorFunctionDefinition(integralOrderFunctionName, controllerSetupObject.IntegralUseErrorSetpointRatio);
             set_param([modelName internalIntegralParametersBlock], 'Value', ['[' num2str(controllerSetupObject.IntegralVectorOfControlErrorValues) ']']);
        otherwise
             integralFunctionScript = fvopidToolbox.app.utils.getUserDefinedFunctionDefinition(integralOrderFunctionName,...
                 controllerSetupObject.IntegralUserDefinedFunction);
    end
    fvopidToolbox.utils.updateMatlabFunctionBlockScript('integral order function', integralFunctionScript,...
        [modelName '/integral order function']);
    
    
    switch controllerSetupObject.DerivativeOrderType
        case fvopidToolbox.app.utils.ControllerSetup.CONSTANT_ORDER
             derivativeFunctionScript = fvopidToolbox.app.utils.getConstantOrderFunctionDefinition(derivativeOrderFunctionName);
        case fvopidToolbox.app.utils.ControllerSetup.FUNCTION_OF_ERROR
             derivativeFunctionScript = fvopidToolbox.app.utils.getFunctionOfErrorFunctionDefinition(derivativeOrderFunctionName, controllerSetupObject.DerivativeUseErrorSetpointRatio);
             set_param([modelName internalDerivativeParametersBlock], 'Value', ['[' num2str(controllerSetupObject.DerivativeVectorOfControlErrorValues) ']']);
        otherwise
             derivativeFunctionScript = fvopidToolbox.app.utils.getUserDefinedFunctionDefinition(derivativeOrderFunctionName,...
                 controllerSetupObject.DerivativeUserDefinedFunction);
    end
    fvopidToolbox.utils.updateMatlabFunctionBlockScript('derivative order function', derivativeFunctionScript,...
        [modelName '/derivative order function']);
end

