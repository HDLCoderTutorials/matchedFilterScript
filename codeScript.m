% All Barker Codes
barkerCode2     = [1,0];
barkerCode3     = [1,1,0];
barkerCode4     = [1,0,1,1];
barkerCode4b    = [1,0,0,0];
barkerCode5     = [1,1,1,0,1];
barkerCode7     = [1,1,1,0,0,1,0];
barkerCode11    = [1,1,1,0,0,0,1,0,0,1,0];
barkerCode13    = [1,1,1,1,1,0,0,1,1,0,1,0,1];

% All unnamed codes
C0 = [0,0,0,0,0,0,0,0];
C1 = [0,1,0,1,0,1,0,1];
C2 = [0,0,1,1,0,0,1,1];
C3 = [0,1,1,0,0,1,1,0];
C4 = [0,0,0,0,1,1,1,1];
C5 = [0,1,0,1,1,0,1,0];
C6 = [0,0,1,1,1,1,0,0];

%PN Codes
pNCodeLength = 100;
pNCodeA = generatePNCode(pNCodeLength,1);
pNCodeB = generatePNCode(pNCodeLength,216732);

% Call codeTest with created codes

%{
figure(1);
codeTest(C1,C2);

figure(4);
codeTest(C4,C6);
sgtitle('C4 with C6')
%}
figure(5);
codeTest(barkerCode13,flip(barkerCode13));
sgtitle('BarkerCode13 with its flipped')

figure(7)
codeTest(pNCodeA,pNCodeB);
sgtitle('PNCodeA with PNCodeB');