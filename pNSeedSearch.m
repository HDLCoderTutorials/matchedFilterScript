%Pick first seed

%Variables
codeSize = 100;
seedA = 1;
codeA = generatePNCode(codeSize,seedA);

%Init
bestSeed = 2;
bestSeedCorrilation = codeSize;
codeB = codeA;

for testSeed = [13158,(1:10000)+4*10000]
    codeB = generatePNCode(codeSize,testSeed);
    xcorrOutput = xcorr(codeA,codeB);
    maxXCorr = max(xcorrOutput);
    if (maxXCorr < bestSeedCorrilation)
        bestSeed = testSeed;
        bestSeedCorrilation = maxXCorr;
    end
end

bestSeedCorrilation
bestSeed

figure(1);
codeB = generatePNCode(codeSize,bestSeed);
codeTest(codeA,codeB);
sgtitle(['length:',num2str(codeSize),'  seedA:',num2str(seedA),'  seedB:',num2str(bestSeed)])

