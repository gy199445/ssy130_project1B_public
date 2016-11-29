function [ sos, eos ] = detectSignal( signal, threshold, N_f )
%DETECTSIGNAL Simple frame based energy detector
%   Returns indices for start and end of signal


    
    % Use first 10 samples to determine noise floor
    noise_floor = sum(abs(signal(1:10*N_f)))/10;

    % If 0 noise, use perfect detection
    if noise_floor == 0
        sos = find(abs(signal) > 0, 1);
        eos = length(signal) - find(abs(flipud(signal)) > 0, 1);
        return;
    end
    
    eps = noise_floor*threshold;
    
    sos = 0; % return 0 if no signal found
    eos = 0;
    i = 1; % current index
    L = length(signal);
    % Detect start of signal
    while i < L - N_f && sos == 0
        if sum(abs(signal(i:(i + N_f - 1)))) > eps
            sos = i;
        end
        i = i + N_f;
    end
    % Detect end of signal
    while i < L - N_f && eos == 0
        if sum(abs(signal(i:(i + N_f - 1)))) < eps
            eos = i + N_f - 1;
        end
        i = i + N_f;
    end

end

