function result = calculateSST2E(timeVector, errorVector, processOutputVector, setpointValue)
    result = sum((errorVector.^2).*(timeVector.^4));
end

