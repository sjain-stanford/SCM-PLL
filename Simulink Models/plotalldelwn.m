%% plot all
clear all;
close all;
clc;
% for del<1
wn = 50*pi;
Vm = 230*sqrt(2);
w_step = 2*pi*10;
t0 = 0.005;
delop = (-1+sqrt(1+4*wn^2*t0^2))/(2*wn*t0)
t = 0:0.00001:0.02;
disp('Enter three values of del<1 for comparision');
for i=1:1:3
    
    del(i)= input(' enter a del<1 ');
    wd1 = wn.*sqrt(1-del(i).^2);
    e_N = exp(-del(i)*wn.*t)/wd1;
    e1 = e_N*w_step;
%     y= e1.*sin(wd1*t);
%     plot(t,y);
    hold on;
    plot(t,e1);
    hold on;
    plot(t,-e1);
end
 
% for del>1
% del2= input(' a value of del >1');
% 
% wd2 = wn*sqrt(del2^2-1);
% e_N2 = exp(-del2*wn*t)/wd2;
% e22 = e_N2*w_step;
% y2= e22.*sinh(wd2*t);

% for del=1

% e_N3 = exp(-wn*t);
% e33 = e_N3*w_step;
% 
% y3= e33.*t;
% 
% plots   
% 
% 
%     plot(t,y2);
%     hold on;
%     plot(t,y3);
%     hold on;
    grid on;
 