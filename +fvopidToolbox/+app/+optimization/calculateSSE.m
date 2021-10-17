function result = calculateSSE(timeVector, errorVector, processOutputVector, setpointValue)
    result = sum(errorVector.*errorVector);
end

