function [ sos, eos ] = detectSignal( signal, threshold )
%DETECTSIGNAL Energy detection of signal
%   Returns indices for start and end of signal

    % Use first N samples to determine noise floor
    N = 1000;
    noise_floor = sum(signal(1:N).^2)/N;

    eps = noise_floor*threshold;    
    
    sos = find(signal.^2 > eps,1);
    eos = length(signal) - find(flipud(signal.^2) > eps, 1);

end

