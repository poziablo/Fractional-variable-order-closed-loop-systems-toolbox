function updateMatlabFunctionBlockScript(matlabFunctionBlockName, newScript, blockPath)
    sfrootObject = sfroot;
    matlabFunctionBlock = sfrootObject.find('Name', matlabFunctionBlockName,'-isa','Stateflow.EMChart', 'Path', blockPath);
    matlabFunctionBlock.Script = newScript;
end

