classdef ControllerSetup
    properties(Constant)
        CONSTANT_ORDER = 'Constant Order';
        FUNCTION_OF_ERROR = 'Function of Error';
        USER_DEFINED_FUNCTION = 'User Defined Function';
        FVOPID_TYPE_A = 'FVOPID Type A';
        FVOPID_CONV_TYPE = 'FVOPID Conv Type';
    end
    
    properties
        ControllerType
        IntegralOrderType
        IntegralUseErrorSetpointRatio
        IntegralVectorOfControlErrorValues
        IntegralUserDefinedFunction
        DerivativeOrderType
        DerivativeUseErrorSetpointRatio
        DerivativeVectorOfControlErrorValues
        DerivativeUserDefinedFunction
    end
end

