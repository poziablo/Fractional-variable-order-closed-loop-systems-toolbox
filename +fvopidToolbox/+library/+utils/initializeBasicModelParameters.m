function initializeBasicModelParameters(h, inputBufferSize, controllerBlockName)
    % Set controller buffer size N
    if inputBufferSize > 0
        set_param([gcb '/Constant_N'], 'Value', num2str(inputBufferSize));
    else
        % Determine buffer size based on simulation end time
        currentSystem = get_param(0, 'CurrentSystem');
        stopTimeString = get_param(currentSystem, 'StopTime');
        stopTimeValue = str2double(stopTimeString);

        N = stopTimeValue/h + 3;
        set_param([gcb '/Constant_N'], 'Value', num2str(N));
    end

    % Set system sample time of internal block
    set_param([gcb '/' controllerBlockName], 'SystemSampleTime', num2str(h));
end

