% Cardan Method with inbuit solve function for solving for wn
clc;
clear all;
close all;

fprintf('\nMethod 3 (optimize both)\n');
E = input('Enter the max. permissible error band, E (rad): ');
t0 = input('Desired settling time, t0 (s): ');

ch = 1;
while(ch == 1)
        fq_step_max = input('\nMax. allowable frequency step: ');
        phi =input('Enter the max permissible phase jump (rad): ');
        
%         E= 0.02;
%         t0=0.01;
%         fq_step_max = 10;
%         fq_step =10;
%         phi=0.5;
%         w_step = 2*pi*10;
        

        w_step_max = 2*pi*fq_step_max;

        temp1 = 0;       
        wn = 2*pi*100; % to start with
        if ( wn - (w_step_max/phi)< 10^-8 )     % special case when c2 -2*c1 =0 
            wn = 2*pi*10;
        end
        
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
                n1 = d/a;
                p= m - (l^2)/3;
                q= (2*(l^3))/27-(l*m/3)+n1;
                if ((q^2 + 4*(p^3)/27)> 0)
                    Y=sqrt((q^2 + 4*(p^3)/27));
                    lambda = ((-q+Y)/2)^1/3;
                    del11= lambda-p/(3*lambda)-l/3;
                    if(del11 > 0 && del11 < 1)
                        del= del11;
                    end
                else
                    r= sqrt((-p/3));
                    X=sqrt(-(q^2 + 4*p^3/27));
                    if (q < 0)
                        thet = (1/3)*atan(X/-q);
                    else
                        thet = pi - (1/3)*atan(X/q);
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
            temp2 =0;
            while(1)
                K = sqrt(w_step_max^2 + wn^2*phi^2 -2*w_step_max*phi*wn*del);
                a1 = -phi^2*del*t0;
                b1 = 2*w_step_max*phi*del^2*t0;
                c1 = -w_step_max^2*del*t0 +w_step_max*phi*del;
                d1 = -w_step_max^2;
                cubic = a1*wn^3 + b1*wn^2 + c1*wn +d1;
                f_x = (k1*K/(wn*exp(del*wn*t0)))- E;
                f_dash_x = k1* cubic /(K*wn^2*exp(del*wn*t0));
                corr = f_x/f_dash_x;
                if (isnan(corr))
                        eq ='E1*wn*exp(del*wn*t0) = k1*sqrt(w_step_max^2 + wn^2*phi^2 -2*w_step_max*phi*wn*del)';
                        eq = subs( eq,{'E1','k1','del','t0','w_step_max','phi'},[E,k1,del,t0,w_step_max,phi]);
                        wn =solve(eq,'wn');
                        wn= subs(wn);
                        res =E*wn*exp(del*wn*t0) - k1*sqrt(w_step_max^2 + wn^2*phi^2 -2*w_step_max*phi*wn*del);
                        res =subs(res);
                        if res > 10^-8
                            disp('something is wrong!!');
                        end       
                end
                if(isnan(corr)~= 1)
                    wn =wn -corr;
                end
                if (abs(temp2-wn))< 0.01
                    break;
                end
                temp2 = wn;
            end
            res = E*wn*exp(del*wn*t0) - k1*sqrt(w_step_max^2 + wn^2*phi^2 -2*w_step_max*phi*wn*del);
            c1 = w_step_max^2 + phi^2*wn^2;
            c2 = wn*phi*w_step_max;
            % disp(res);
            if res > 10^-8
                disp('something is wrong!!');
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
        fprintf('\nDamping ratio, del: %f\nNatural frequency, wn (in rad/s): %f\n',del,wn);
        fprintf('\n\nThe designed values of kp, ki and Tau : ');
        fprintf('\nProportional gain, kp = %f',kp);
        fprintf('\nIntegral gain, ki = %f',ki);
        fprintf('\nTime constant, Tau = %f ms\n',Tau*1e+3);
%         ch =1;
%         x =0:0.0001:0.999;
%         Err = (2*exp(-x*wn*t0)./(wn*sqrt(1-x.^2))).*sqrt(c1-2*c2*x);
%         plot(x,Err);
%         grid on;
        ch = menu('Continue?','Yes','No');
end