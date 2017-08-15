clc
clear all
close all

w =  input('Enter w: ');
del = input('Enter del: ');
wn = input('Enter wn: ');
Em=-230*sqrt(2);
ki = (wn^2)/Em;
kp = 2*del*wn/Em;

num = wn^4+4*del^2*wn^2*w^2;
den = (wn^2-w^2)^2+4*del^2*wn^2*w^2;

M = sqrt(num/den);
% M2 = 2*-Em*M
