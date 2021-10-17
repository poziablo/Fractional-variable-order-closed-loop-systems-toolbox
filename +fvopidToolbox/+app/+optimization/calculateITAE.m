function result = calculateITAE(timeVector, errorVector, processOutputVector, setpointValue)
    result = trapz(timeVector, timeVector .* abs(errorVector));
end

