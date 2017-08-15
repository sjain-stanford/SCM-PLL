clc;
clear all;
close all;

% Inputs to be given by the user
% 1) settling time t0 (w.r.t. time of occurrence of excursion)
% 2) max. permissible error, E, at t0
% 3) max. allowable frequency step
% 4) max. allowable phase jump

% DDSRF
wf=2*pi*50/sqrt(2);

% DSOGI
k = sqrt(2);

% MCCF
wc = 2*pi*50;

% Discrete_SRF
Ts = 0.1e-3;  % sampling period = default MATLAB sampling period

E = input('Enter the max. permissible error band, E (rad): ');
t0 = input('Desired settling time, t0 (s): ');
fq_step_max = input('\nMax. allowable frequency step (Hz): ');
fq_step = input('Frequency step observed (Hz): ');
ph_jump_max = input('\nMax. allowable phase jump (rad): ');
ph_jump = input('Phase jump observed (rad): ');
cycles = input('\nNo. of cycles to be observed per change: ');
simtime = cycles*20e-3*14;  % 13 different grid conditions are used (multi-port switch) + 1 as cushion band

w_step_max = 2*pi*fq_step_max;
w_step = 2*pi*fq_step;
% Values for plots
% t0 = 0.01;
% E = 0.02;  
% fq_step_max = 10;
% fq_step = 5;
% ph_jump_max = pi/6;
% ph_jump = 0.1;

cont = 1;
while cont == 1
    ch = menu('Choose a design method:','Wiener Method','Self-consistent model optimization');
    switch(ch)
         case 1
            fprintf('\nWiener Method\n');
            del = 1/sqrt(2);
            wn = input('Enter the value of wn: ');

         case 2
            fprintf('\nSelf-consistent model optimization\n');        
            temp1 = 0;      % Measure that the self consistent equations in del and wn have reached sufficient accuracy of del
            temp2 = 0;      % To deal with accuracy in wn
            num = 0;        % Iteration count
            wn = 2*pi*100;  % to start with         
            c1 = w_step_max^2 + ph_jump_max^2*wn^2;
            c2 = wn*ph_jump_max*w_step_max;            

            while(1)
                num = num+1;                
                % Solve for del
                if c2==0
                    % Either w_step_max or ph_jump_max is zero
                    del = (-1+sqrt(1+4*wn^2*t0^2))/(2*wn*t0);
                elseif c1-2*c2 == 0
                    del = 0.999;
                elseif c2+c1*wn*t0 < 0
                    del = 0;
                else
                    % When c2+c1*wn*t0 > 0 and c1-2*c2 != 0
                    % Cardan's solution of cubic equation in del
                    a = -2*wn*t0*c2;
                    b = -c2+wn*t0*c1;
                    c = c1+2*wn*t0*c2;
                    d = -c2-wn*t0*c1;
                    l = b/a;
                    m = c/a;
                    n = d/a;
                    p = m - (l^2)/3;
                    q = (2*(l^3))/27-(l*m/3)+n;

                    if q^2 + 4*(p^3)/27 > 0
                        % Only one real root of del --> has to be necessarily in (0,1)
                        Y = sqrt(q^2 + 4*(p^3)/27);
                        lambda = ((-q+Y)/2)^(1/3);
                        del = lambda-p/(3*lambda)-l/3;
                    else
                        % All roots of del are real
                        r = sqrt(-p/3);
                        X = sqrt(-(q^2 + 4*p^3/27));
                        if q < 0
                            thet = (1/3)*atan(X/-q);
                        else
                            thet = pi-(1/3)*atan(X/q);
                        end
                        del1 = 2*r*cos(thet) -l/3;
                        del2 = 2*r*cos(thet - 2*pi/3) - l/3;
                        del3 = 2*r*cos(thet + 2*pi/3) - l/3;
                        if del1 > 0 && del1 < 1
                            del = del1;
                        elseif del2 > 0 && del2 < 1
                            del = del2;
                        else
                            del = del3;
                        end
                    end
                end

                % Now compute wn for the previous del
                k1 = 2/sqrt(1-del^2);
                while(1)
                    num = num+1;
                    % Newton Raphson
                    K = sqrt(w_step_max^2 + wn^2*ph_jump_max^2 - 2*w_step_max*ph_jump_max*wn*del);
                    a1 = -ph_jump_max^2*del*t0;
                    b1 = 2*w_step_max*ph_jump_max*del^2*t0;
                    c1 = -w_step_max^2*del*t0 + w_step_max*ph_jump_max*del;
                    d1 = -w_step_max^2;
                    cubic = a1*wn^3 + b1*wn^2 + c1*wn +d1;
                    f_x = (k1*K/(wn*exp(del*wn*t0)))- E;
                    f_dash_x = k1*cubic/(K*wn^2*exp(del*wn*t0));
                    corr = f_x/f_dash_x;
                    if isnan(corr)
                        % Newton Raphson fails when the wn equation has oscillations (cubic) --> Hence going for MATLAB 'solve'
                        eq = 'E1*wn*exp(del*wn*t0) = k1*sqrt(w_step_max^2 + wn^2*ph_jump_max^2 - 2*w_step_max*ph_jump_max*wn*del)';
                        eq = subs(eq,{'E1','k1','del','t0','w_step_max','ph_jump_max'},[E,k1,del,t0,w_step_max,ph_jump_max]);
                        wn = solve(eq,'wn');
                        wn = subs(wn);
                        % Debug
                        res = E*wn*exp(del*wn*t0) - k1*sqrt(w_step_max^2 + wn^2*ph_jump_max^2 - 2*w_step_max*ph_jump_max*wn*del);
                        if abs(res) > 10^-4
                            disp('\nSomething is wrong in MATLAB solve!');
                        end
                    else
                        wn = wn - corr;
                    end                    
                    if abs(temp2-wn) < 0.01
                        % Break out of the wn solve loop
                        break;
                    end
                    temp2 = wn;
                end

                if abs(temp1-del) < 0.0001
                    % Break out of the entire loop
                    break                 
                end            
                temp1 = del;
                % Updating the values of c1 and c2 for the next del computation, since wn has been updated now
                c1 = w_step_max^2 + ph_jump_max^2*wn^2;
                c2 = wn*ph_jump_max*w_step_max;                
            end                  
            fprintf('No. of iterations taken: %d',num);             
    end

    c1 = w_step^2 + ph_jump^2*wn^2;
    c2 = wn*ph_jump*w_step;
    c1_max = w_step_max^2 + ph_jump_max^2*wn^2;
    c2_max = wn*ph_jump_max*w_step_max;

    error = (2*exp(-del*wn*t0))/(wn*sqrt(1-del^2))*sqrt(c1-2*c2*del);
    error_max = (2*exp(-del*wn*t0))/(wn*sqrt(1-del^2))*sqrt(c1_max-2*c2_max*del);

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

    cont = menu('Continue?','Yes','No');
end
