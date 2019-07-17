function codeTest(code1,code2)

figure(1);
plot(xcorr(code1,code2));
title('Cross Corilation');

figure(2);
plot(xcorr(code1));
title('autoCorilation-Code 1');

figure(3);
plot(xcorr(code2));
title('autoCorilation-Code 2');

end