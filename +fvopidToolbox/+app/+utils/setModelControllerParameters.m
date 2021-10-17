function setModelControllerParameters(modelName, controllerParametersObject)
    controllerBlockName = '/GL FVOPID';
    integralParametersBlock = '/constant_integralParametersVector';
    derivativeParametersBlock = '/constant_derivativeParametersVector';

    set_param([modelName controllerBlockName], 'kp', num2str(controllerParametersObject.Kp));
    set_param([modelName controllerBlockName], 'ki', num2str(controllerParametersObject.Ki));
    set_param([modelName controllerBlockName], 'kd', num2str(controllerParametersObject.Kd));
    
    set_param([modelName integralParametersBlock], 'Value', ['[' num2str(controllerParametersObject.IntegralParametersVector) ']']);
    set_param([modelName derivativeParametersBlock], 'Value', ['[' num2str(controllerParametersObject.DerivativeParametersVector) ']']);
end

