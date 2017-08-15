%MCCF bode plots
close all
clear all
clc
w0 = 2*pi*50;
wc = w0/sqrt(2);
w = -1000:0.1:1000;
M1= abs(w0.*w)./sqrt((w.^2-w0^2).^2 + (w0*w).^2); 
M2 = wc./ sqrt(wc^2 + (w-w0).^2);
plot (w, M1);
hold on
% atemp =input('any key to continue');
plot(w, M2);
hold on
grid on
xlabel('\bf frequency (rad/s)\rightarrow');
ylabel('\bf Magnitude (abs)\rightarrow');

