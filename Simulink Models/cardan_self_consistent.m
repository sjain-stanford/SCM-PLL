% Cardan Method
clc;
clear all;
close all;

fprintf('\nMethod 3 (optimize both)\n');
E = input('Enter the max. permissible error band, E (rad): ');
t0 = input('Desired settling time, t0 (s): ');

Em = -230*sqrt(2);

ch = 1;
while(ch == 1)
        fq_step_max = input('\nMax. allowable frequency step: ');
        phi =input('Enter the max permissible phase jump (rad): ');
        
        % E= 0.02;
        % t0=0.01;
        % fq_step_max = 10;
        % fq_step =10;
        % phi=0.5;
        % w_step = 2*pi*10;       

        w_step_max = 2*pi*fq_step_max;

        temp1 = 0;
        num = 0;        
        wn = 2*pi*10; % to start with
        c1 = w_step_max^2 + phi^2*wn^2;
        c2 = wn*phi*w_step_max;

        while(1)
         
            if(c2==0)
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
                q = 2*(l^3)/27 - l*m/3 + n;
                
                if q^2 + 4*(p^3)/27 > 0
                    % Only one real root
                    Y = sqrt(q^2 + 4*(p^3)/27);
                    lambda = ((-q+Y)/2)^1/3;
                    del = lambda - p/(3*lambda) - l/3;
                else
                    % All roots are real
                    r = sqrt(-p/3);
                    X = sqrt(-(q^2 + 4*p^3/27));
                    if q < 0
                        thet = (1/3)*atan(X/-q);
                    else
                        thet = pi - (1/3)*atan(X/q);
                    end
                    
                    del1 = 2*r*cos(thet) - l/3;
                    del2 = 2*r*cos(thet-2*pi/3) - l/3;
                    del3 = 2*r*cos(thet+2*pi/3) - l/3;
                    
                    if (del1 > 0 && del1 < 1)
                        del = del1;
                    elseif (del2 > 0 && del2 < 1 )
                        del = del2;
                    elseif (del3 >0 && del3 <1)
                        del = del3;
                    end                    
                end
            end
            
            temp2 = 0;
            k1 = 2/sqrt(1-del^2);
            
            while(1)
                num = num+1;
%                 if (num == 2)
%                 temp = input('');
%                 end
                k3 = (k1/E)*sqrt(c1-2*c2*del);
                % [wn] = solve('wn*exp(del*wn*t0)= k3')
                wn = lambertw(0, del*k3*t0)/(del*t0);
                if abs(wn-temp2) < 0.01
                    break
                end
                temp2 = wn;
                c1 = w_step_max^2 + phi^2*wn^2;
                c2 = wn*phi*w_step_max;
            end
            if abs(temp1-del) < 0.0001
                break                 
            end
            temp1 = del;
        end
        
        %Design of kp and ki
        
        ki = (wn^2)/Em;
        kp = 2*del*wn/Em;
        Tau = kp/ki;  
        fprintf('No. of iterations taken: %d',num);
        fprintf('\nDamping ratio, del: %f\nNatural frequency, wn (in rad/s): %f\n',del,wn);
        fprintf('\n\nThe designed values of kp, ki and Tau : ');
        fprintf('\nProportional gain, kp = %f',kp);
        fprintf('\nIntegral gain, ki = %f',ki);
        fprintf('\nTime constant, Tau = %f ms\n',Tau*1e+3);

        ch = menu('Continue?','Yes','No');
end
