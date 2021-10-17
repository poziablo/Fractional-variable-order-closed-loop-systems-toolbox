function result = calculateITSE(timeVector, errorVector, processOutputVector, setpointValue)
    result = trapz(timeVector, timeVector .* errorVector.^2);
end

