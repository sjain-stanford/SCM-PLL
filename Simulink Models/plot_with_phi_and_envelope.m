%%Plot of error with time

clear all
close all
clc
t= 0:0.0001:0.1;
t0 =0.01;
del= 0.1;
wn = 100*pi;
w_step = 2*pi*10;
phi = 0.1;

wd= wn*sqrt(1-del^2);
gamma =acos(del);
c1 = w_step^2 + (phi^2)*(wn^2);
c2 = w_step*phi*wn;

e_t = (exp(-del*wn*t)/wd).*(w_step*sin(wd*t)-phi*wn*sin(wd*t-gamma));
plot(t,e_t);
xlabel('\bftime(s)\rightarrow');
ylabel('\bfe(t) \rightarrow');
hold on

env_plus = (exp(-del*wn*t)/wd)*sqrt(c1 -2*c2*del);
plot(t, env_plus);
hold on

env_minus = -(exp(-del*wn*t)/wd)*sqrt(c1 -2*c2*del);
plot(t, env_minus);
grid on

% atemp = input('Enter a key to continue.');
% 
% 
% wn = 100*pi;
% wd= wn*sqrt(1-del^2);
% gamma =acos(del);
% e_t = (exp(-del*wn*t)/wd).*(w_step_max*sin(wd*t)-phi*wn*sin(wd*t-gamma));
% plot(t,e_t);
% grid on;
% hold on;