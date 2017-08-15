clear all
close all
clc
del = 0:0.0001:0.9990;
wn =100*pi; 
% case 1: E_dash(0) < 1 ---> c2 + c1*wn*t0 > 0 ( choose a positive c2 then this condition will be always true)
    t0 =0.01;
    % subcase 1 : E(del appraches one) approaches infinity 
    w_step = 2*pi*10;
    phi = 0.1;
    c1 = w_step^2 +wn^2*phi^2;
    c2 = w_step*phi*wn;
    E = (2*exp(-del*wn*t0)./(wn*sqrt(1-del.^2))).*sqrt(c1-2*c2*del);
    plot(del,E);
    xlabel('\bf damping ratio,\delta \rightarrow');
    ylabel('\bf Error band,E (rad) \rightarrow');
    grid on
    atemp =input(' Press a key to continue');
    % subcase 2 : case when c1 -2c2 =0
    %wn = w_step/phi
    w_step = 2*pi*10;
    phi = 0.2;
    c1 = w_step^2 +wn^2*phi^2;
    c2 = w_step*phi*wn;
    E = (2*exp(-del*wn*t0)./(wn*sqrt(1-del.^2))).*sqrt(c1-2*c2*del);
    plot(del,E)
    xlabel('\bf damping ratio,\delta \rightarrow');
    ylabel('\bf Error band,E (rad) \rightarrow');
    grid on
    atemp =input(' Press a key to continue');
% case 2: E_dash(0) > 1  condition : c2 + c1*wn*to < 0 
t0 = 0.001;    % implies 2*wn*t0 < 1
w_step = 2*pi*10;
phi = -0.1;
c1 = w_step^2 +wn^2*phi^2;
c2 = w_step*phi*wn;
del = 0:0.0001:0.9950;
E = (2*exp(-del*wn*t0)./(wn*sqrt(1-del.^2))).*sqrt(c1-2*c2*del);
plot(del,E)
xlabel('\bf damping ratio,\delta \rightarrow');
ylabel('\bf Error band,E (rad) \rightarrow');
grid on
atemp =input(' Press a key to continue');

% plotting f(del) ---> the cubic for case 2
t0 = 0.001;    % implies 2*wn*t0 < 1 and case 2
w_step = 2*pi*10;
phi = -0.1;
c1 = w_step^2 +wn^2*phi^2;
c2 = w_step*phi*wn;
del = 0:0.0001:1;
f_del = (-2*wn*t0*c2)*del.^2 + (-c2 + wn*t0*c1)*del.^2 + (c1 + 2*wn*t0)*del + (-c2 - wn*t0*c1);
plot(del,f_del);
xlabel('\bf damping ratio,\delta \rightarrow');
ylabel('\bf f(\delta) \rightarrow');
grid on


