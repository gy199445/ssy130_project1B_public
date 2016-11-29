%% Plot signal spectrum
close all;
NN = 2^14; % Number of frequency grid points
f = (0:NN-1)/NN; % Frequency vectors
F = (0:NN-1)/NN*fs;

% Plot spectrum of z
figure;
semilogy(f,abs(fft(z.',NN))) % Check transform
xlabel('relative frequency f/fs');
title('Spectrum of z');

% Plot upsampled z
figure;
semilogy(f,abs(fft(zu.',NN))) % Check transform
xlabel('normalized frequency f/fs');
title('Spectrum of upsampled z');

% Plot interpolated signal
figure;
semilogy(f,abs([fft(zu.',NN) fft(zi.',NN) fft(B.',NN)]) ) % Check transforms
legend('Up-sampled z_u','Interpolated after LP filtering','LP-filter')
xlabel('relative frequency f/fs');
title('Effects of interpolation');

% Plot modulated signal
figure;
semilogy(F,abs([fft(zi.',NN) fft(zm.',NN) ]) ) % Check transforms
legend('Interpolated','Modulated')
xlabel('Frequency (Hz)');
title('Effects of modulation');

% Plot spectrum of transmitted real signal
figure;
semilogy(F,abs([fft(zi.',NN) fft(zm.',NN) fft(zmr.',NN) ]) ) % Check transforms
legend('Interpolated','Modulated','Real and modulated')
xlabel('Frequency (Hz)');
title('Transmitted signal');

% Plot transmitted signal in time domain
figure;
plot((1:length(ytrans)).*(1/fs),ytrans);
ylabel('Amplitude');
xlabel('t [s]');

% Plot received real signal after energy detection
figure;
semilogy(F,abs([fft(yrec.',NN) ]) ) % Check transforms
xlabel('Frequency (Hz)');
title('Received signal');

% Plot demodulated received signal
figure;
semilogy(F,abs([fft(yrec.',NN) fft(yib.',NN) ])); % Check transforms
legend('Modulated','Demodulated')
xlabel('Frequency (Hz)');
title('Demodulated received signal');

% Plot low-passed demodulated signal
figure;
semilogy(f,abs([fft(yib.',NN) fft(yi.',NN) fft(B.',NN)]) ) % Check transforms
legend('Demodulated','after LP filtering','LP-filter')
xlabel('relative frequency f/fs');

% Plot down-sampled signal
figure;
semilogy(f,abs([fft(y.',NN)]) ); % Check transforms
xlabel('relative frequency f/fs');
title('Downsampled signal');

%% Plot estimated channel
figure;
subplot(2,1,1);
plot(abs(H_));
title('Estimated channel H(k)');
ylabel('|H(k)|');
subplot(2,1,2);
plot(unwrap(angle(H_)));
ylabel('\angle H(k) [rad]');
xlabel('k');