clc;
clear all;
close all;
% To plot the Bode magnitude response of an SRF-PLL for a varying set of 'del'

wn = 100*pi;
del = [0.1 0.5 1/sqrt(2) 0.9];


    Ac = tf([2*del(1)*wn wn^2],[1 2*del(1)*wn wn^2]);    
    bodemag(Ac);
    hold on;
    Bc = tf([2*del(2)*wn wn^2],[1 2*del(2)*wn wn^2]);    
    bodemag(Bc);
    hold on;
    Cc = tf([2*del(3)*wn wn^2],[1 2*del(3)*wn wn^2]);    
    bodemag(Cc);
    hold on;
    Dc = tf([2*del(4)*wn wn^2],[1 2*del(4)*wn wn^2]);    
    bodemag(Dc);
    hold on;
    grid on;

