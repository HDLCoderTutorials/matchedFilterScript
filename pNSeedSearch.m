%Pick first seed

%Variables
codeSize = 100;
seedA = 1;
codeA = generatePNCode(codeSize,seedA);

%Init
bestSeed = 2;
bestSeedCorrilation = codeSize;
codeB = codeA;

seedList = floor([216732,1e0:1e5]);
% seedList = floor([45562,1e0:1e5]); % for codeSize = 1000

f = waitbar(0,'you are waiting');
for seedIndex = 1:numel(seedList)
    testSeed = seedList(seedIndex);
    codeB = generatePNCode(codeSize,testSeed);
    xcorrOutput = xcorr(codeA,codeB);
    maxXCorr = max(abs(xcorrOutput));
    if (maxXCorr < bestSeedCorrilation)
        bestSeed = testSeed;
        bestSeedCorrilation = maxXCorr;
        % Show preliminary results
        figure(1)
        codeTest(codeA,codeB);
        sgtitle(['length:',num2str(codeSize),'  seedA:',num2str(seedA),'  seedB:',num2str(testSeed)])
        drawnow
    end
    if(mod(seedIndex,floor(numel(seedList)/1000))==0)
        waitbar(seedIndex/numel(seedList),f);
        drawnow
    end
end
close(f);


bestSeedCorrilation
bestSeed
figure(1);
codeB = generatePNCode(codeSize,bestSeed);
codeTest(codeA,codeB);
sgtitle(['length:',num2str(codeSize),'  seedA:',num2str(seedA),'  seedB:',num2str(bestSeed)])

%Best seed = 216732

