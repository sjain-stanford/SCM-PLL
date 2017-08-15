clc;
clear all;
close all;

% Inputs to be given by the user
% 1) settling time t0 (w.r.t. time of occurrence of excursion)
% 2) max. permissible error, E, at t0
% 3) max. allowable frequency step

% Temporary Design for DDSRF
% kP = -20;
% kI = -246.7;
wf=2*pi*50/sqrt(2);

% DSOGI
k = sqrt(2);

% MCCF
wc = 2*pi*50;

% Discrete_SRF
Ts = 0.8e-3;  % sampling period

t0 = input('Desired settling time, t0 (s): ');
fq_step_max = input('Max. allowable frequency step (Hz): ');
fq_step = input('Frequency step observed (Hz): ');
cycles = input('No. of cycles to be observed per change: ');
simtime = cycles*20e-3*14;  % 13 different grid conditions are used (multi-port switch) + 1 as cushion band

% Values for plots
% t0 = 0.01;
% E = 0.02;  
% fq_step_max = 10;
% fq_step = 5;

while(1)
ch = menu('Choose a design method:','Approach 1 (quantify error)','Approach 2 (optimize del)','Approach 3 (optimize both)');
 switch(ch)
     case 1
         fprintf('\nApproach 1 (quantify error)\n');
         E = input('Enter the max. permissible error band, E: ');
         E_N = E/(2*pi*fq_step_max);
         del = input('Enter the damping ratio, del: ');
         % simplified version of [wn] = solve('E_N*wn*sqrt(1-del^2) = 2*exp(-del*wn*t0)')
         wn = lambertw(0, (2*del*t0)/(E_N*(1 - del^2)^(1/2)))/(del*t0);
         
     case 2
         fprintf('\nApproach 2 (optimize del)\n');
         wn = input('Enter the assumed wn (rad/s): ');
         del = (-1+sqrt(1+4*wn^2*t0^2))/(2*wn*t0);
         
     case 3
         fprintf('\nApproach 3 (optimize both)\n');
         E = input('Enter the max. permissible error band, E: ');
         E_N = E/(2*pi*fq_step_max);
         wn = 2*pi*50;  % to start with
         temp= 0;
         n = 0;
         while(1)
             n = n+1;
             del = (-1+sqrt(1+4*wn^2*t0^2))/(2*wn*t0);
             % simplified version of [wn]=solve('E_N*wn*sqrt(1-del^2) = 2*exp(-del*wn*t0)')
             wn = lambertw(0, (2*del*t0)/(E_N*(1 - del^2)^(1/2)))/(del*t0);               
             if abs(del-temp) <= 0.0001
                 break                 
             end
             temp = del;
         end                     
         fprintf('No. of iterations taken: %d',n);        
 end
  
norm_error = (2*exp(-del*wn*t0))/(wn*sqrt(1-del^2));
error = norm_error*2*pi*fq_step;
error_max = norm_error*2*pi*fq_step_max;
% Design of kp and ki
Em = -230*sqrt(2);
kp = 2*del*wn/Em;
ki = (wn^2)/Em;
Tau = kp/ki;  

fprintf('\nError band observed at t0: %f\nMax error band, E: %f\nDamping ratio, del: %f\nNatural frequency, wn (in rad/s): %f\n',error,error_max,del,wn);
fprintf('\n\nThe designed values of kp, ki and Tau from Approach %d:\n',ch);
fprintf('\nProportional gain, kp = %f',kp);
fprintf('\nIntegral gain, ki = %f',ki);
fprintf('\nTime constant, Tau = %f ms\n',Tau*1e+3);

a = menu('Try another method?','Yes','No');
if a == 2
    break
end
end