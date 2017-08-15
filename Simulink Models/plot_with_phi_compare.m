%plot to compare bet weiner and proposed method
clear all
close all
clc
w_step = 2*pi*10;
phi = pi/6;
%weiner
del = 1/sqrt(2);
wn = 100*pi;
c1 = w_step^2 + phi^2*wn^2;
c2 = w_step* phi*wn;
wd  = wn*sqrt(1-del^2);
gamma =acos(del);
t = 0:0.0001:0.02;
e = (exp( -del*wn*t)/wd).*(w_step*sin(wd*t) - phi*wn*sin(wd*t -gamma));
e1 = (exp( -del*wn*t)/wd)*sqrt(c1- 2*c2*del);
e2 = -(exp( -del*wn*t)/wd)*sqrt(c1- 2*c2*del);
plot(t,e);
hold on
% atemp = input('enter: ');
% plot(t,e1);
% hold on
% plot(t,e2);
% atemp = input('enter: ');
xlabel('time(s) \rightarrow ');
ylabel(' e(t) \rightarrow ');
grid on

%proposed
atemp = input('Proposed method:');
del = 0.91228;
wn = 505.8244;
c1 = w_step^2 + phi^2*wn^2;
c2 = w_step* phi*wn;
wd =wn*sqrt(1-del^2);
gamma = acos(del);
t = 0:0.0001:0.02;
e = (exp( -del*wn*t)/wd).*(w_step*sin(wd*t) - phi*wn*sin(wd*t -gamma));
e1 = (exp( -del*wn*t)/wd)*sqrt(c1- 2*c2*del);
e2 = -(exp( -del*wn*t)/wd)*sqrt(c1- 2*c2*del);
plot(t,e);
hold on
% atemp = input('enter: ');
% plot(t,e1);
% hold on
% atemp = input('enter: ');
% plot(t,e2);
xlabel('time(s) \rightarrow ');
ylabel(' e(t) \rightarrow ');
grid on