classdef ObjectiveFunctionSetup
    properties(Constant)
        ISE = 'ISE';
        IAE = 'IAE';
        ITAE = 'ITAE';
        ITSE = 'ITSE';
        SSE = 'SSE';
        SSTE = 'SSTE';
        SST2E = 'SST2E';
        USER_DEFINED = 'USER DEFINED';
    end
    
    properties
        ObjectiveFunctionType
        CustomObjectiveFunctionInvocation
    end
end

