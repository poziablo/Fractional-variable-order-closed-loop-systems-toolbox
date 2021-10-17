modelName = 'testFVOPID';
modelNameFullPath = ['fvopidToolbox/test/models/' modelName];
load_system(modelNameFullPath);

% Run simulation
tic()
for i = 1:20
    simulationOutput = sim(modelName);
end
toc()