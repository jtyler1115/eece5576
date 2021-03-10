clear all;
close all;
fs = 50000; %50GHz/(10^3)
T_s = 2*(10^-9);
Rs = 1/(T_s*10^6);
Ns = 100;
fc = 1000;
[data,N,s,ts]=tx_QPSK(fs,Rs,Ns,fc);
%fs: vector points per microseconds (sampling frequency)
%Rs: symbol rate in Mbauds (Msymbols/s) 
%Ns: number of symbols to simulate
%fc: carrier frequency in MHz

%N: points per symbol
%s: signal transmitted
%ts: time vector of the signal transmitted
figure()
plot(ts,s)
title('Transmitted Signal')
xlabel('Time(s)')
ylabel('Signal')
channel = 3;

dirac1 = dirac(ts);
idx = dirac1 == Inf;
dirac1 (idx) = 1;

dirac2 = dirac(ts-4*10^(-10));
idx = dirac2 == Inf;
dirac2(idx) = 1;

dirac3 = dirac(ts-6*10^(-10));
idx = dirac3 == Inf;
dirac3(idx) = 1;

dirac4 = dirac(ts-2*10^(-9));
idx = dirac4 == Inf;
dirac4(idx) = 1;

dirac5 = dirac(ts-4*10^(-9));
idx = dirac5 == Inf;
dirac5(idx) = 1;


h1=0.8*dirac1;
h2=0.7*dirac1-0.6*dirac2+0.5*dirac3;
h3=0.4*dirac1-0.7*dirac4-0.5*dirac5;

if channel == 1
    h=h1;
elseif channel == 2
    h=h2;
elseif channel == 3
    h=h3;
end


th = ts;
[r,tr]=channel_and_noise(h,th,s,ts);

%h:  impulse response of the channel
%th: time (tau) vector for h (time vector used to create h --> You could consider th=ts)
%s:  transmitted signal at the input of the channel
%ts: time vector for s

%r:   signal after channel transmission and the addition of AWGN noise
%tr:  time vector of the signal r
figure()
plot(ts,r)
title('Corrupted Signal (Channel 1)')


[I,Q,datar]=rx_QPSK(fs,Rs,Ns,fc,r)
%fs: vector points per microseconds (sampling frequency)
%Rs: symbol rate in Mbauds (Msymbols/s) 
%Ns: number of symbols to simulate
%fc: carrier frequency in MHz
%r:  input signal to the receiver

%I:      In-phase componenet after demodulation
%Q:      Quadrature componenet after demodulation
%datar:  recovered data 

figure()
scatter(I,Q)
ax = gca()
ax.XAxisLocation = 'origin'
ax.YAxisLocation = 'origin'
title('Receiver Constellation (Channel 1)')
xlabel('I')
ylabel('Q')

bitErrors = sum(datar ~= data)