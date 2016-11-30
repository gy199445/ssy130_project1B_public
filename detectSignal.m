function [ sos, eos ] = detectSignal( signal, threshold, N_f )
%DETECTSIGNAL Simple frame based energy detector
%   Inputs: signal, SNR to detect signal, number of samples per frame
%   Returns indices for start and end of signal
    
    % Use first 10 frames to determine noise floor
    noise_floor = sum(abs(signal(1:10*N_f)))/10;

    % If 0 noise, use perfect detection
    nf_eps = 1E-2;
    if noise_floor == 0
        sos = find(abs(signal) > nf_eps, 1);
        eos = length(signal) - find(abs(flipud(signal)) > nf_eps, 1);
        return;
    end
    
    % Determine energy threshold from noise floor
    eps = noise_floor*threshold;
    
    sos = 0; % return 0 if no signal found
    eos = 0;
    i = 1; % current index
    L = length(signal);
    % Detect start of signal
    while i < L - N_f && sos == 0
        % Detect start if average frame amplitude is above energy threshold
        if sum(abs(signal(i:(i + N_f - 1)))) > eps
            sos = i;
        end
        % Advance one frame
        i = i + N_f;
    end
    % Detect end of signal after having found the start
    while i < L - N_f && eos == 0
        % Detect end if average frame amplitude is below energy threshold
        if sum(abs(signal(i:(i + N_f - 1)))) < eps
            eos = i + N_f - 1;
        end
        i = i + N_f;
    end

end

