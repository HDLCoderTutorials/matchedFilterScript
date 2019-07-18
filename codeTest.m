function codeTest(code1,code2)

if(max(size(code1) ~= size(code2)))
    warning('codes sizes much be equal');
end
assert(max(max([code1,code2])) == 1,'max code value should be equal to one');

for index = 1:numel(code1)
    if(code1(index) ~= 1)
        code1(index) = -1;
    end
end
for index = 1:numel(code2)
    if(code2(index) ~= 1)
        code2(index) = -1;
    end
end

% figure(1);
subplot(3,1,1);
plot(xcorr(code1,code2));
title('Cross Corilation');

subplot(3,1,2);
plot(xcorr(code1));
title('autoCorilation-Code 1');

subplot(3,1,3);
plot(xcorr(code2));
title('autoCorilation-Code 2');

end