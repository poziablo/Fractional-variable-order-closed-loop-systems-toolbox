function [ avaluesVector ] = getAvaluesVector( order, maxK )
    avaluesVector = [1 zeros(1, maxK)];
    
    for i = 2:maxK+1
        avaluesVector(i) = avaluesVector(i-1) * (1 - ((order + 1)/(i-1)));
    end 
end

