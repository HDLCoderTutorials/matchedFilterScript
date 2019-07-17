code1 = [1,-1,1,1,1,-1,-1]; 
code2 = [-1,-1,-1,1,-1,1,-1];
barkerCode13 = [1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];
barkerCode13_neg = -barkerCode13;

% codeTest(code1,code2);
codeTest(barkerCode13,flip(barkerCode13_neg));