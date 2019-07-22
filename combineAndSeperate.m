%% Variables 
rxSignalLength = 1000;
pNCodeLength = 100;
pNCodeA = generatePNCode(pNCodeLength,1);
pNCodeB = generatePNCode(pNCodeLength,6442);
%pNCodeA = ones(1,pNCodeLength/2);
pNCodeC = generatePNCode(pNCodeLength,2);

%% Create an input signal
rxSignal = zeros(1,rxSignalLength);

rxSignal = addDelayedSignal(rxSignal,pNCodeA,[400,450,500]);
rxSignal = addDelayedSignal(rxSignal,pNCodeB,[800,450,59]);
rxSignal = addDelayedSignal(rxSignal,pNCodeC,200);

%% Create some noise
noiseAmp = .5;
noise = (randn(1,rxSignalLength)-0.5)*2*noiseAmp;

%% Combine the input singal and the noise
rxSignal = rxSignal + noise;

%% Step over and plot the auto Corilation
figure(2);

subplot(4,1,2);
corOutputA = xcorr(rxSignal,pNCodeA);
plot(corOutputA(rxSignalLength:end));
title('Code A Corilation Output');

subplot(4,1,1);
plot(rxSignal);
title('raw rxSignal');


subplot(4,1,3);
corOutputB = xcorr(rxSignal,pNCodeB);
plot(corOutputB(rxSignalLength:end));
title('Code B Corilation Output');


subplot(4,1,4);
corOutputC = xcorr(rxSignal,pNCodeC);
plot(corOutputC(rxSignalLength:end));
title('Code C Corilation Output');
