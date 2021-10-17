classdef ClosedLoopSystemSetup    
    properties
        SetpointValue
        ControllerSampleTime
        OutputSampleTime
        BufferSize
        LimitControllerOutput
        ControllerOutputUpperLimit
        ControllerOutputLowerLimit
        PlantTransferFunctionNominator
        PlantTransferFunctionDenominator
        DiscretePlant
        DiscretePlantSampleTime
        TransportDelay
        SimulationTime
    end
end

