modelName = 'testFOPID';
modelNameFullPath = ['fvopidToolbox/test/models/' modelName];
load_system(modelNameFullPath);

% Run simulation
tic()
for i = 1:10
    simulationOutput = sim(modelName);
end
toc()