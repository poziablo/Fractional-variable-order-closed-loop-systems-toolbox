function setModelBasicSetup(modelName, closedLoopSystemSetupObject)
    setpointBlockName = '/constant_setpointValue';
    controllerBlockName = '/GL FVOPID';
    plantBlockName = '/Plant';
    processOutputBlock = '/processOutput';
    viOutputBlock = '/viOutput';
    vdOutputBlock = '/vdOutput';
    errorOutputBlock = '/errorOutput';
    controlOutputBlock = '/controlOutput';
    transportDelayBlock = '/Transport Delay Block';

    set_param([modelName setpointBlockName], 'Value', num2str(closedLoopSystemSetupObject.SetpointValue));
    controllerSampleTimeString = num2str(closedLoopSystemSetupObject.ControllerSampleTime);
    set_param([modelName controllerBlockName], 'sampleTime', controllerSampleTimeString);
    outputSampleTime = closedLoopSystemSetupObject.OutputSampleTime;
    if (outputSampleTime == -1)
        outputSampleTimeString = controllerSampleTimeString;
    else
        outputSampleTimeString = num2str(outputSampleTime);
    end
    set_param([modelName processOutputBlock], 'SampleTime', outputSampleTimeString);
    set_param([modelName viOutputBlock], 'SampleTime', outputSampleTimeString);
    set_param([modelName vdOutputBlock], 'SampleTime', outputSampleTimeString);
    set_param([modelName errorOutputBlock], 'SampleTime', outputSampleTimeString);
    set_param([modelName controlOutputBlock], 'SampleTime', outputSampleTimeString);
    set_param([modelName controllerBlockName], 'inputBufferSize', num2str(closedLoopSystemSetupObject.BufferSize));
    
    if closedLoopSystemSetupObject.LimitControllerOutput
       set_param([modelName controllerBlockName], 'satEnab', 'On');
       set_param([modelName controllerBlockName], 'satHigh', num2str(closedLoopSystemSetupObject.ControllerOutputUpperLimit));
       set_param([modelName controllerBlockName], 'satLow', num2str(closedLoopSystemSetupObject.ControllerOutputLowerLimit));
    else
       set_param([modelName controllerBlockName], 'satEnab', 'Off');
    end
    
    set_param([modelName plantBlockName], 'Numerator', ['[' num2str(closedLoopSystemSetupObject.PlantTransferFunctionNominator) ']']);
    set_param([modelName plantBlockName], 'Denominator', ['[' num2str(closedLoopSystemSetupObject.PlantTransferFunctionDenominator) ']']);
    
    if closedLoopSystemSetupObject.DiscretePlant
        set_param([modelName plantBlockName], 'SampleTime', num2str(closedLoopSystemSetupObject.DiscretePlantSampleTime));
    end
    
    if closedLoopSystemSetupObject.TransportDelay > 0
        set_param([modelName transportDelayBlock], 'DelayTime', num2str(closedLoopSystemSetupObject.TransportDelay));
    end
end

