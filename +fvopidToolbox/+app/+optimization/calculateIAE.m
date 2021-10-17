function result = calculateIAE(timeVector, errorVector, processOutputVector, setpointValue)
     result = trapz(timeVector, abs(errorVector));
end

