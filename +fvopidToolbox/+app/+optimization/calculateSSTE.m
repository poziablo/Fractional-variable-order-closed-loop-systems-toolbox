function result = calculateSSTE(timeVector, errorVector, processOutputVector, setpointValue)
    result = sum((errorVector.^2).*(timeVector.^2));
end

