modelName = 'TestSimulinkOptimizedModel';

load_system(modelName);

% Run simulation
tic()
for i = 1:100
    simulationOutput = sim(modelName);
end
toc()