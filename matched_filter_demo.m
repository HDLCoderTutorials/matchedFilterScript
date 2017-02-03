%Demo a matched filter with a square pulse and a chirped pulse.
%Show sliding convolution window and output.
% Compare range resolution.



c=3e8; %speed of light, m/s
signal_amplitude = 10; %arbitrary. 
noise_amplitude = 45;
snr_db = 10*log10(signal_amplitude/noise_amplitude); %?
carrier_freq = 10e9; %10kHz
points_per_carrier_cycle = 30;
cycles_per_sim=2000; %How many cycles should fit in whole sim?
time_vector = 0:1/(points_per_carrier_cycle*carrier_freq):...
    cycles_per_sim/carrier_freq;
    if max(size(time_vector)) > 10e6 %avoid accidentally filling memeory.
        error(['Time vector is a bit large ',num2str(max(size(time_vector))),' data points'])
    end
%Generate pulse
carrier_waveform = signal_amplitude * sin(2*pi*carrier_freq*time_vector);

pulse_delay_cycles = 0;
pulse_delay = pulse_delay_cycles / carrier_freq;
pulse_width_cycles = 200;
pulse_width = pulse_width_cycles / carrier_freq;
baseband_waveform = u_step(time_vector - pulse_delay) - ...
    u_step(time_vector - (pulse_width + pulse_delay));

%PLOT PULSE ENVELOPE
figure(1);subplot_1_size=4;
subplot(subplot_1_size,1,1)
plot(time_vector,baseband_waveform)
title({'Pulse Envelope';sprintf('Carrier = %.2e  Hz',carrier_freq)})
xlabel('time (seconds)')
ylabel('Amplitude')
 
   


%PLOT TX WAVEFORM
transmit_waveform = carrier_waveform .* baseband_waveform;

subplot(subplot_1_size,1,2)
plot(time_vector,transmit_waveform)
title({'Transmit Pulse Waveform';...
    sprintf('Pulse Width = %.2e  seconds',pulse_width)})
xlabel('time (seconds)')
ylabel('Amplitude')

%CREATE AND PLOT Rx SQUARE PULSE WAVEFORM (w/ noise and delays)
%Add Noise for Rx waveform
real_noise = noise_amplitude * randn(size(time_vector));
%Add loop for range delays as well...
target_delay_cycles=[500 1000 1050];%target_delay_cycles=[50 75 80 83 110 150];
target_delay_time = target_delay_cycles / carrier_freq;
target_delay_index = zeros(size(target_delay_time)); %init for loop
%Loop over earch target
receive_waveform_noise_added = zeros(size(time_vector)); %initialize rx waveform for loop
for i = 1:size(target_delay_time,2)
 %convert delay_time to delay_samples   
target_delay_index(i) = find(min(abs(time_vector-target_delay_time(i)))==...
    abs(time_vector-target_delay_time(i)));
%Old intuitive, but less robust way >> %find(time_vector==target_delay_time(i)); %find how much to shift transmit_waveform by
receive_waveform_noise_added(target_delay_index(i):end)=...
    receive_waveform_noise_added(target_delay_index(i):end)+...
    transmit_waveform(1:end-target_delay_index(i)+1);
end
receive_waveform_noise_added = receive_waveform_noise_added + real_noise; %Add the noise

subplot(subplot_1_size,1,3)
plot(time_vector,receive_waveform_noise_added)
title(['Received Pulse Waveform (with ',num2str(round(snr_db,2,'significant')),' dB SNR)'])
xlabel('time (seconds)')
ylabel('Amplitude')

%MATCHED FILTER OF SQUARE PULSE
%sweep 'receive_waveform_noise_added' with reversed 'transmit_waveform'
truncated_tx_waveform=transmit_waveform(baseband_waveform>0);
conv_output = abs( conv(receive_waveform_noise_added,fliplr(truncated_tx_waveform)) );
truncated_conv_output = conv_output(1,1:size(time_vector,2));
%figure(2)
subplot(subplot_1_size,1,4)
plot(truncated_conv_output)
title('Convolution Output. Square Pulse Matched Filter')

% subplot(subplot_1_size,1,5)
% plot(abs(conv(receive_waveform_noise_added,fliplr(truncated_tx_waveform(1:end-round(size(truncated_tx_waveform,2)*.9))),'same')))
% title('Convolution(m,n,same) 1/10th the conv width')

%% Generate Chirped waveform! (This really might need to be complex...)

chirp_bandwidth_percentage = .05; %Percent of carrier frequency
chirp_bandwidth = carrier_freq * chirp_bandwidth_percentage;
chirp_width = pulse_width;
chirp_rate = chirp_bandwidth/pulse_width;
chirp_start = pulse_delay;

%Create and plot baseband_chirp_waveform
% baseband_chirp_waveform = zeros(size(time_vector));
baseband_chirp_waveform = cos(2*pi*chirp_rate*(time_vector-pulse_delay).^2) .* ...
    baseband_waveform;
figure(2);subplot_2_size = 4;
subplot(subplot_2_size,1,1)
plot(time_vector,baseband_chirp_waveform,...
    time_vector,baseband_waveform)
title({'Chirp at baseband';sprintf('Carrier = %.2e  Hz',carrier_freq)})
xlabel('time (seconds)')
ylabel('Amplitude')

%Create and plot Transmit Pulse Waveform
transmit_chirp_waveform = baseband_chirp_waveform .* carrier_waveform;
subplot(subplot_2_size,1,2)
plot(time_vector,transmit_chirp_waveform)
title({'Transmit Chirp Waveform (mixed with carrier)';...
    sprintf('Chirp Bandwidth = %.2e  Hz',chirp_bandwidth)})
xlabel('time (seconds)')
ylabel('Amplitude')

%Create and plot Rx Chirp Pulse Waveform (w/ nosie and delays)
%real_noise is created above

%Loop over earch target
receive_chirp_waveform_noise_added = zeros(size(time_vector)); %initialize rx waveform for loop
for i = 1:size(target_delay_time,2)
 %convert delay_time to delay_samples   
% target_delay_index(i) already calculated above
receive_chirp_waveform_noise_added(target_delay_index(i):end)=...
    receive_chirp_waveform_noise_added(target_delay_index(i):end)+...
    transmit_chirp_waveform(1:end-target_delay_index(i)+1);
end
receive_chirp_waveform_noise_added = receive_chirp_waveform_noise_added + real_noise; %Add the noise

% receive_chirp_waveform_noise_added = transmit_chirp_waveform + real_noise;



subplot(subplot_2_size,1,3)
plot(time_vector,receive_chirp_waveform_noise_added)
title(['Received Chirped Pulse Waveform (with ',num2str(round(snr_db,2,'significant')),' dB SNR)'])
xlabel('time (seconds)')
ylabel('Amplitude')








%MATCHED FILTER OF CHIRPED PULSE
truncated_tx_chirp_waveform=transmit_chirp_waveform(baseband_waveform>0);
conv_output_chirp = abs( conv(receive_chirp_waveform_noise_added,fliplr(truncated_tx_chirp_waveform)) ); 
truncated_conv_output_chirp = conv_output_chirp(1,1:size(time_vector,2));
%figure(2)
subplot(subplot_2_size,1,4)
plot(truncated_conv_output_chirp)
title('Convolution Output. Chirped Pulse Matched Filter')

% subplot(subplot_1_size,1,5)
% plot(abs(conv(receive_chirp_waveform_noise_added,fliplr(truncated_tx_chirp_waveform),'same')))
% title('Convolution(m,n,same)')



