% To test SRF PLL

clc;
clear all;
close all;

kp = -1.526099;
ki = -265.691088;

% If Ts_act < Ts    --->    Surely stable
% If Ts_act >> Ts   --->    Surely unstable
% If Ts_act > Ts    --->    Maybe stable
Ts = 0.3125e-3;         % Designed
Ts_act = 0.3125e-3;   % Actual

Ki = Ts*ki*0.5;
wff = 314.15926;

thetatemp = 0;	
theta = 0;		
vdtemp = 0;		
delwtemp = 0;
wtemp = wff;
% theta_junk = rand*pi;
theta_junk = 0;
    
t = 0;
i = 1;
Theta = zeros(1,1);
Vd = zeros(1,1);
Vq = zeros(1,1);
time = zeros(1,1);

while t <= 0.5  % 15 cycles
    va = 230*sqrt(2)*sin(100*pi*t+theta_junk);
    vb = 230*sqrt(2)*sin(100*pi*t-2*pi/3+theta_junk);
    vc = 230*sqrt(2)*sin(100*pi*t+2*pi/3+theta_junk);

    vbeta = 0.6667*va - 0.333*(vb+vc);
    valpha = 0.5773*(vc-vb);

    vq = cos(theta)*vbeta - sin(theta)*valpha;
    vd = sin(theta)*vbeta + cos(theta)*valpha;

    delw = (kp+Ki)*vd + (Ki-kp)*vdtemp + delwtemp;

    w = delw + wff;
    theta = 0.5*Ts*(w + wtemp) + thetatemp;
   
    if theta >= 6.283
        theta = 0;
    end

    vdtemp = vd;
    thetatemp = theta;
    delwtemp = delw;
    wtemp = w;    

    Theta(i) = theta;
    Vd(i) = vd;
    Vq(i) = vq;
    time(i) = t;
    
    i = i+1;
    t = t+Ts_act;
end



newVd = (Vd+325.2691)*1.57254399;
newVq = (Vq+325.2691)*1.57254399;
newTheta = Theta*162.8155;

plot(time,newVd);
grid on;

% plot(time,newVq);
% grid on;

% plot(time,newTheta);
% grid on;