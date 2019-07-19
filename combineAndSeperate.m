%% Variables 
rxSignalLength = 1000;
pNCodeLength = 100;
pNCodeA = generatePNCode(pNCodeLength,1);
pNCodeB = generatePNCode(pNCodeLength,216732);
% pNCodeA = ones(1,pNCodeLength);

%% Create an input signal
rxSignal = zeros(1,rxSignalLength);

rxSignal = addDelayedSignal(rxSignal,pNCodeA,[400,450,500]);
rxSignal = addDelayedSignal(rxSignal,pNCodeB,[800,39,59]);

%% Create some noise
noiseAmp = 0;
noise = (rand(1,rxSignalLength)-0.5)*2*noiseAmp;

%% Combine the input singal and the noise
rxSignal = rxSignal + noise;

%% Step over and plot the auto Corilation
figure(2);

subplot(3,1,2);
corOutputA = xcorr(rxSignal,pNCodeA);
plot(corOutputA(rxSignalLength:end));
title('Code A Cor Output');

subplot(3,1,1);
plot(rxSignal);
title('raw rxSignal');


subplot(3,1,3);
corOutputB = xcorr(rxSignal,pNCodeB);
plot(corOutputB(rxSignalLength:end));
title('Code B Cor Output');

