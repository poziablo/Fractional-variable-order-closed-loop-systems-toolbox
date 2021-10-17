function modelName = initializeModel(closedLoopSystemSetupObject, controllerSetupObject)
    % Determinie the model which should be used for the simulation
    switch controllerSetupObject.ControllerType
        case fvopidToolbox.app.utils.ControllerSetup.FVOPID_TYPE_A
            % Use simulink models for Type A controller
            if closedLoopSystemSetupObject.DiscretePlant
                if closedLoopSystemSetupObject.TransportDelay > 0
                    modelName = 'typeA_ClosedLoop_delay_discretePlant_2018a';
                else
                    modelName = 'typeA_ClosedLoop_discretePlant_2018a';
                end
            else
                if closedLoopSystemSetupObject.TransportDelay > 0
                    modelName = 'typeA_ClosedLoop_delay_continousPlant_2018a';
                else
                    modelName = 'typeA_ClosedLoop_continousPlant_2018a';
                end
            end
        otherwise
           % Use simulink models for Convolution Type controller
           if closedLoopSystemSetupObject.DiscretePlant
                if closedLoopSystemSetupObject.TransportDelay > 0
                    modelName = 'convType_ClosedLoop_delay_discretePlant_2018a';
                else
                    modelName = 'convType_ClosedLoop_discretePlant_2018a';
                end
            else
                if closedLoopSystemSetupObject.TransportDelay > 0
                    modelName = 'convType_ClosedLoop_delay_continousPlant_2018a';
                else
                    modelName = 'convType_ClosedLoop_continousPlant_2018a';
                end
            end
    end
    
    modelNameFullPath = ['fvopidToolbox/app/models/' modelName];
    
    % Load model
    load_system(modelNameFullPath);
    
    % Set basic model parameters
    fvopidToolbox.app.utils.setModelBasicSetup(modelName, closedLoopSystemSetupObject);
    fvopidToolbox.app.utils.setModelController(modelName, controllerSetupObject);
end

