% correlation with various signals

c=3e8; %speed of light, m/s
signal_amplitude = 10; %arbitrary. 
noise_amplitude = 45;
snr_db = 10*log10(signal_amplitude/noise_amplitude); %?

carrier_freq = 10e3; %10kHz
points_per_carrier_cycle = 30;
cycles_per_sim=200; %How many cycles should fit in whole sim?
time_vector = 0:1/(points_per_carrier_cycle*carrier_freq):...
    cycles_per_sim/carrier_freq;
    if max(size(time_vector)) > 10e6 %avoid accidentally filling memeory.
        error(['Time vector is a bit large ',num2str(max(size(time_vector))),' data points'])
    end
%Generate pulse
carrier_waveform_complex = signal_amplitude * exp(i*2*pi*carrier_freq*time_vector);



figure(1);
plot( real(carrier_waveform_complex))


figure(2);
correlationOutput = xcorr(carrier_waveform_complex)
plot(abs(correlationOutput))