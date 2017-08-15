close all
clear all
clc
del =0.1
fn =[50, 200, 1000 ]
wn =2*pi*fn;
% wn =[100*pi, 1000*pi,2000*pi, 20000*pi]
i =1;
siz = size(wn);
while( i<=siz(1,2))
    sys = tf([(2*del*wn(i)), wn(i)^2],[1,(2*del*wn(i)), wn(i)^2]);
    bodemag(sys);
    hold on
    grid on
    i =i+1;
end
    
    
    
    
