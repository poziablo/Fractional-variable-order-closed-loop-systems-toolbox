function setMaskParameterPropertyValue(parameterName, propertyName, propertyValue)
    parameterIndex = strcmp(get_param(gcb, 'MaskNames'), parameterName);
    maskVector = get_param(gcb, propertyName);
    maskVector{parameterIndex} = propertyValue;
    set_param(gcb, propertyName, maskVector);
end

