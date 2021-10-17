function setMaskElementVisiblePropertyValue(elementName, propertyValue)
    p = Simulink.Mask.get(gcb); 
    param = p.getDialogControl(elementName); 
    param.Visible = propertyValue;
end

