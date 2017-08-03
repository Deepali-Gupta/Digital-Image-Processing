function SNR = snr2(signal, noise, typ, noisy)
if ~exist('typ', 'var')
    typ = 'db';
end
if ~exist('noisy', 'var')
    noisy = false;
end

if noisy % eval noise
    noise = signal-noise;
end

if strcmp(typ,'db')
    SNR = 20*log10(sqrt (mean (signal .^2) )/sqrt (mean (noise .^2) ));
elseif strcmp(typ,'amp')
    SNR = (sqrt (mean (signal .^2) )/sqrt (mean (noise .^2) ));
end
end