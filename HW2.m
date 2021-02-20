% Problem 1
% Plot correction factor as function of antenna height
clear all;
close all;
result1={};
idx=1;
for freq = [300 900 1500]
    for height = 1:100
        alpha = (1.1*log10(freq)-.7)*height-(1.56*log10(freq)-.8);
        output(height,2)=alpha;
        output(height,1)=height;
    end
    result1{idx}=output;
    idx=idx+1;
end
figure()
plot(result1{1}(:,1),result1{1}(:,2));
hold on;
plot(result1{2}(:,1),result1{2}(:,2));
hold on;
plot(result1{3}(:,1),result1{3}(:,2));
xlabel('Antenna Height, $h_r$ (m)', 'interpreter', 'latex')
ylabel('Correction Factor, $\alpha(h_r)$', 'interpreter', 'latex')
title('\textbf{Correction Factor as a Function of $h_r$}', 'interpreter', 'latex')
legend('$f_c = 300$ MHz','$f_c = 900$ MHz','$f_c = 1500$ MHz', 'interpreter', 'latex')


%Problem 2
%Plot Okumura-Hata Path Loss over Distance
result2 = {}
ht = 100;
fc = 900;
idx = 1
for hr = [1 3 5]
    i = 1;
    for d = 1:.1:20
        alpha2 = (1.1*log10(fc)-.7)*hr-(1.56*log10(fc)-.8);
        A = 69.55 + 26.16*log10(fc) - 13.82*log10(ht) - alpha2;
        B =44.9 - 6.55*log10(ht);
        LPU = A +B*log10(d);
        LPS = LPU - 2*((log10(fc/28))^2) - 5.4;
        output2(i,1) = d;
        output2(i,2) = LPS;
        i = i + 1;
    end
    result2{idx} = output2;
    idx = idx + 1;
end

figure()
plot(result2{1}(:,1),result2{1}(:,2));
hold on;
plot(result2{2}(:,1),result2{2}(:,2));
hold on;
plot(result2{3}(:,1),result2{3}(:,2));
xlabel('Distance, $d$ (m)', 'interpreter', 'latex')
ylabel('Okumura-Hata Path Loss (dB)', 'interpreter', 'latex')
title('\textbf{Okumura-Hata Path Loss as a Function of Distance}', 'interpreter', 'latex')
legend('$h_r = 1$ m','$h_r = 3$ m','$h_r = 5$ m', 'interpreter', 'latex')

%Problem 3
%Plot Difference in Path Loss over Distance
result3 = {};
idx = 1;
c = 3*(10^8);
for hr = [1 3 5]
    i = 1;
    for d = 1:.1:20
        alpha2 = (1.1*log10(fc)-.7)*hr-(1.56*log10(fc)-.8);
        A = 69.55 + 26.16*log10(fc) - 13.82*log10(ht) - alpha2;
        B =44.9 - 6.55*log10(ht);
        LPU = A +B*log10(d);
        LPS = LPU - 2*((log10(fc/28))^2) - 5.4;
        LP = 32.45 + 20*log10(fc)+20*log10(d);
        output3(i,1) = d;
        output3(i,2) = LPS - LP;
        i = i + 1;
    end
    result3{idx} = output3;
    idx = idx + 1;
end

figure()
plot(result3{1}(:,1),result3{1}(:,2));
hold on;
plot(result3{2}(:,1),result3{2}(:,2));
hold on;
plot(result3{3}(:,1),result3{3}(:,2));
xlabel('Distance, $d$ (m)', 'interpreter', 'latex')
ylabel('Difference in Path Loss (dB)', 'interpreter', 'latex')
title('\textbf{Difference between Free Space and Okumura-Hata Path Loss (dB)}', 'interpreter', 'latex')
legend('$h_r = 1$ m','$h_r = 3$ m','$h_r = 5$ m', 'interpreter', 'latex')