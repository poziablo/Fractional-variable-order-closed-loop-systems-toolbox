modelName = 'TestSimulinkOptimizedModel';

load_system(modelName);

% find_system(modelName,'Variants','AllVariants')
get_param('TestSimulinkOptimizedModel/fvopid','ObjectParameters')