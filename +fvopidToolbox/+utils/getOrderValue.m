function y = getOrderValue(e, errorValuesVector, orderValuesVector)
    for i = 1:length(errorValuesVector)
        if e < errorValuesVector(i)
            y = orderValuesVector(i);
            return
        end
    end

    y = orderValuesVector(length(errorValuesVector) + 1);
end

