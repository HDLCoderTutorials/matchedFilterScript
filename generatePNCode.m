function [pNCode] = generatePNCode(size,optionalSeed)

    assert(numel(size) == 1,'size should be one element');
    if (nargin == 2)
        rng(optionalSeed);
    end
    pNCode = rand(1,size);
    pNCode(pNCode>0.5) = 1;
    pNCode(pNCode<=0.5) = -1;
end