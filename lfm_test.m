%LFM test
%A script I found that I think is bugged, but what the hey.

t=(-10:.05:10);
lfm=exp(j*t.*t);
figure(1)
subplot(3,1,1)
plot(real(lfm));
y=conv(lfm,lfm');
subplot(3,1,2)
plot(real(y))
subplot(3,1,3)
% plot(20*log10(abs(y)));
plot(20*log10(abs(fftshift(fft(y))))) %is this right? I think it is.