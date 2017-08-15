% 3D Lookup Table

clc;
clear all;
close all;

fprintf('\nMethod 3 (optimize both)\n');
E = input('Enter the max. permissible error band, E (rad): ');
t0 = input('Desired settling time, t0 (s): ');

Em = -230*sqrt(2);

Del = zeros(20,8);
Wn = zeros(20,8);
Ki = zeros(20,8);
Kp = zeros(20,8);
Tau = zeros(20,8);

x = 1;
for w_step_max = 0:2*pi*0.5:2*pi*10
    y = 1;
    for phi = 0:0.025:0.2
            
            if phi == 0 && w_step_max == 0      % No requirement to design, hence skip 
                y = 2;
                continue
            end
            x
            y
            
            temp = 0;   % Measure that the self consistent equations in del and wn have reached sufficient accuracy of del
            temp2 = 0;  % To deal with uncertainties in 'solve'
            num = 0;    % Iteration count
            wn = 2*pi*100; % to start with

            if ( wn - (w_step_max/phi)< 10^-8 )     % special case when c2 -2*c1 =0 
                wn = 2*pi*10;
            end
            c1 = w_step_max^2 + phi^2*wn^2;
            c2 = wn*phi*w_step_max;


            while(1)
                num = num+1;
                if(c2==0)
                    % Either w_step_max or phi is zero
                    del = (-1+sqrt(1+4*wn^2*t0^2))/(2*wn*t0);
                else
                    a = -2*wn*t0*c2;
                    b = -c2+wn*t0*c1;
                    c = c1+2*wn*t0*c2;
                    d = -c2-wn*t0*c1;

                    l = b/a;
                    m = c/a;
                    n = d/a;

                    p = m - (l^2)/3;
                    q = (2*(l^3))/27-(l*m/3)+n;

                    if (q^2 + 4*(p^3)/27) > 0
                        % Only one real root
                        Y = sqrt(q^2 + 4*(p^3)/27);
                        lambda = ((-q+Y)/2)^1/3;
                        del11 = lambda-p/(3*lambda)-l/3;
                        if(del11 > 0 && del11 < 1)
                            del= del11;
                        else
                            disp('No root in (0,1) --> c1-2c2 = 0'); % Not happened so far
                        end
                    else
                        % All roots are real
                        r = sqrt(-p/3);
                        X = sqrt(-(q^2 + 4*p^3/27));
                        if (q < 0)
                            thet = (1/3)*atan(X/-q);
                        else
                            thet = pi-(1/3)*atan(X/q);
                        end
                        del1 = 2*r*cos(thet) -l/3;
                        del2 = 2*r*cos(thet - 2*pi/3) - l/3;
                        del3 = 2*r*cos(thet + 2*pi/3) - l/3;
                        if (del1 > 0 && del1 < 1)
                            del = del1;
                        elseif (del2 > 0 && del2 < 1 )
                            del = del2;
                        elseif (del3 >0 && del3 <1)
                            del = del3;
                        end
                    end
                end

                k1 = 2/sqrt(1-del^2);
                eq = 'E1*wn*exp(del*wn*t0) = k1*sqrt(w_step_max^2 + wn^2*phi^2 - 2*w_step_max*phi*wn*del)';
                eq = subs(eq,{'E1','k1','del','t0','w_step_max','phi'},[E,k1,del,t0,w_step_max,phi]);
                wn = solve(eq,'wn');
                wn = subs(wn)
                % special case when w_step is zero -> eliminate wn =0 which is also a solution
                % wn is a column vector when multiple values exist
                s = size(wn); 
                if s(1) > 1
                    wn = wn(2);
                    disp('hi');
                % case when no explicit solution can be found
                elseif s(1) == 0
                    wn = temp2+10;
                    continue
                end                
                
                % To debug
                res = E*wn*exp(del*wn*t0) - k1*sqrt(w_step_max.^2 + wn^2*phi.^2 -2*w_step_max.*phi*wn*del);
                res = subs(res);
                if res > 10^-8
                    disp('something is wrong!!');
                end

                % Updating the values of c1 and c2, since wn has changed now
                c1 = w_step_max^2 + phi^2*wn^2;
                c2 = wn*phi*w_step_max;

                if abs(temp-del) < 0.0001 || abs(temp2-wn) < 0.01
                    break                 
                end            
                temp = del;
                temp2 = wn;
            end
        
            % Design of kp and ki 
            ki = (wn^2)/Em;
            kp = 2*del*wn/Em;
            tau = kp/ki;  
            
            Del(x,y) = del;
            Wn(x,y) = wn;
            Ki(x,y) = ki;
            Kp(x,y) = kp;
            Tau(x,y) = tau;
            
            y = y+1;
    end
    
x = x+1;

end
% (1,1) corresponds to the case when both frequency jump and phase jump is zero -> design is not required
Del(1,1) = NaN;
Wn(1,1) = NaN;
Ki(1,1) = NaN;
Kp(1,1) = NaN;
Tau(1,1) = NaN;


w_step_max = 0:2*pi*0.5:2*pi*10;
phi = 0:0.025:0.2;
surf(phi,w_step_max,real(Del));
% surf(phi,w_step_max,real(Wn));
% surf(phi,w_step_max,real(Ki));
% surf(phi,w_step_max,abs(real(Ki)));
% surf(phi,w_step_max,real(Kp));
% surf(phi,w_step_max,abs(real(Kp)));
% surf(phi,w_step_max,real(Tau));

