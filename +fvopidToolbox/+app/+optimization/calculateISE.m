function result = calculateISE(timeVector, errorVector, processOutputVector, setpointValue)
    result = trapz(timeVector, errorVector.^2);
end

