clc;
clear all;
close all;

fprintf('\nMethod 3 (optimize both)\n');
E = input('Enter the max. permissible error band, E (rad): ');
t0 = input('Desired settling time, t0 (s): ');
count = 0;
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
        n = 0;        
        wn = 2*pi*1; % to start with
        c1 = w_step_max^2 + phi^2*wn^2;
        c2 = wn*phi*w_step_max;

        while(1)
            n = n+1;
            if(c2==0)
                del = (-1+sqrt(1+4*wn^2*t0^2))/(2*wn*t0);
            else
                a = -2*wn*t0*c2;
                b = -c2+wn*t0*c1;
                c = c1+2*wn*t0*c2;
                d = -c2-wn*t0*c1;
                
                l = b/a;
                m = c/a;
                n1 = d/a;
                
                p = m-l^2/3;
                q = 2*l^3/27 - l*m/3 + n1;
                var = q^2+4*p^3/27;
                
                if var < 0;
                    count = count+1;
                end
                    
                
                % del1 is always a real root of solve('a*x^3+b*x^2+c*x+d = 0')
                del1 = (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3) - b/(3*a) - (c/(3*a) - b^2/(9*a^2))/(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3);
                del2 = (c/(3*a) - b^2/(9*a^2))/(2*(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)) - b/(3*a) - (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)/2 + (3^(1/2)*((c/(3*a) - b^2/(9*a^2))/(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3) + (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3))*i)/2;
                del3 = (c/(3*a) - b^2/(9*a^2))/(2*(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)) - b/(3*a) - (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3)/2 - (3^(1/2)*((c/(3*a) - b^2/(9*a^2))/(((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3) + (((d/(2*a) + b^3/(27*a^3) - (b*c)/(6*a^2))^2 + (c/(3*a) - b^2/(9*a^2))^3)^(1/2) - b^3/(27*a^3) - d/(2*a) + (b*c)/(6*a^2))^(1/3))*i)/2;
                if (del1 < 1 && del1 > 0)
                    del = del1;
                elseif (abs(imag(del2))<1e-8 && real(del2)<1 && real(del2)>0)
                    del = del2;
                elseif (abs(imag(del3))<1e-8 && real(del3)<1 && real(del3)>0)
                    del = del3;
                end
            end
            temp2 =0;
            k1 = 2/sqrt(1-del^2);
            while(1)
        %       wn = (k1/E_N)*exp(-del*wn*t0)*sqrt(1+k2*wn^2); Just for
        %       memory :-)
%                 n = n+1;
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
        Em=-230*sqrt(2);
        ki = (wn^2)/Em;
        kp = 2*del*wn/Em;
        Tau = kp/ki;  
        fprintf('No. of iterations taken: %d',n);
        fprintf('\nDamping ratio, del: %f\nNatural frequency, wn (in rad/s): %f\n',del,wn);
        fprintf('\n\nThe designed values of kp, ki and Tau : ');
        fprintf('\nProportional gain, kp = %f',kp);
        fprintf('\nIntegral gain, ki = %f',ki);
        fprintf('\nTime constant, Tau = %f ms\n',Tau*1e+3);

        ch = menu('Continue?','Yes','No');
end


x = 0:0.001:0.999;
E = 2*exp(-x*wn*t0).*sqrt(c1-2*c2*x)./(wn*sqrt(1-x.^2));
plot(x,E)
grid on


% 
% %%Plot of error with time
% 
% t= 0:0.0001:0.02;
% wd= wn*sqrt(1-del^2);
% gamma =acos(del);
% e_t = (exp(-del*wn*t)/wd).*(w_step_max*sin(wd*t)-phi*wn*sin(wd*t-gamma));
% plot(t,e_t);
% xlabel('\bftime(s)\rightarrow');
% ylabel('\bfe(t) \rightarrow');
% grid on;
% hold on;
% 
% 
% del= 0.5;
% wn = 100*pi;
% wd= wn*sqrt(1-del^2);
% gamma =acos(del);
% e_t = (exp(-del*wn*t)/wd).*(w_step_max*sin(wd*t)-phi*wn*sin(wd*t-gamma));
% plot(t,e_t);
% grid on;