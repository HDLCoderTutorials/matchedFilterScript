function [rxSignal] = addDelayedSignal(rxSignal,addedSignal,targetDelays)


for iDelay = 1:numel(targetDelays)
    
    currentDelay = targetDelays(iDelay);

    rxSignal(currentDelay:(-1+currentDelay+numel(addedSignal)))= ...
        rxSignal(currentDelay:(-1+currentDelay+numel(addedSignal)))+addedSignal;

end


end