% ----------------------------------------------------------------------*
% Approach 3 (fq_step + ph_jump)                                        *
%                                                                       *
% Optimization at the given frequency step and phase jump               *
%                                                                       *
% Authors: Sambhav R Jain, Pradhyumna Ravikirthi                        *
%                                                                       *
% ----------------------------------------------------------------------*

clc;
clear all;
close all;

fprintf('\nSelf-consistent model based optimization\n');
E = input('Enter the max. permissible error band, E (rad): ');
t0 = input('Desired settling time, t0 (s): ');

ch = 1;
while(ch == 1)
        fq_step_max = input('\nMax. allowable frequency step (Hz): ');
        ph_jump_max = input('\nMax. allowable phase jump (rad): ');
        
%         E= 0.02;
%         t0=0.01;
%         fq_step_max = 10;
%         ph_jump_max = 0.5;

        w_step_max = 2*pi*fq_step_max;
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
            
        % Design of kp and ki
        Em = -230*sqrt(2);
        ki = (wn^2)/Em;
        kp = 2*del*wn/Em;
        Tau = kp/ki;  
        fprintf('\nDamping ratio, del: %f\nNatural frequency, wn (in rad/s): %f\n',del,wn);
        fprintf('\n\nThe designed values of kp, ki and Tau : ');
        fprintf('\nProportional gain, kp = %f',kp);
        fprintf('\nIntegral gain, ki = %f',ki);
        fprintf('\nTime constant, Tau = %f ms\n',Tau*1e+3);

        ch = menu('Continue?','Yes','No');
end