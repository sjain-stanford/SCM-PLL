% ----------------------------------------------------------------------*
% 3D Lookup Table for Approach 3 (fq_step + phi)                        *
%                                                                       *
% Optimization at different possible frequency steps and phase jumps    *
%                                                                       *
% Sambhav R Jain (sambhav.eee@gmail.com)                                *
% Pradhyumna Ravikirthi (pradhyumnarao@gmail.com)                       *
% NIT Trichy                                                            *
% March 2012                                                            *
% ----------------------------------------------------------------------*

clc;
clear all;
close all;

fprintf('\n3D Lookup Table\n');

E = input('Enter the max. permissible error band, E (rad): ');
t0 = input('Desired settling time, t0 (s): ');
Em = -230*sqrt(2);

xlim = input('Enter the limits of frequency step in Hz (e.g. [-10 10])\n--> Kindly specify steps only above 0.5 Hz with a decimal rounding to 0.5:\n');
ylim = input('Enter the limits of phase jump in rad (e.g. [-0.5 0.5]):\n');
xlim = xlim*2*pi;       % To convert Hz to rad/s
del_x = 2*pi*0.5;       % Increment in fq_step
del_y = 0.025;          % Increment in phase jump
n_x = (xlim(2)-xlim(1))/del_x;
n_y = (ylim(2)-ylim(1))/del_y;

Del = zeros(n_x,n_y);
Wn = zeros(n_x,n_y);
Ki = zeros(n_x,n_y);
Kp = zeros(n_x,n_y);
Tau = zeros(n_x,n_y);

x = 1; 
for w_step_max = xlim(1) : del_x : xlim(2)
    y = 1;
    for phi = ylim(1) : del_y : ylim(2)            
            if phi == 0 && w_step_max == 0      % No requirement to design, hence skip 
                x_zero = x;     % Store the index at which design not required
                y_zero = y;     % Store the index at which design not required
                y = y+1;        % Skip            
                continue
            end
            fprintf('\nCurrent index (x,y): (%d,%d)',x,y);
            
            temp1 = 0;      % Measure that the self consistent equations in del and wn have reached sufficient accuracy of del
            temp2 = 0;      % To deal with accuracy in wn
            num = 0;        % Iteration count
            wn = 2*pi*100;  % to start with
%             if abs(wn-(w_step_max/phi)) < 10^-8
%                 % special case when c1-2*c2 = 0 (i.e. Assumed wn is not suitable as it would result in no root of E in del = (0,1) interval)
%                 % disp('Warning: Special case!');
%                 wn = 2*pi*10;
%             end            
            c1 = w_step_max^2 + phi^2*wn^2;
            c2 = wn*phi*w_step_max;
            
            
            while(1)
                num = num+1;                
                % Solve for del
                if c2==0
                    % Either w_step_max or phi is zero
                    del = (-1+sqrt(1+4*wn^2*t0^2))/(2*wn*t0);
                elseif c1-2*c2 == 0
                    del = 0.999;
                elseif c2+c1*wn*t0 < 0
                    del = 0;
                else % When c2+c1*wn*t0 > 0 and c1-2*c2 != 0
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
%                         if del11 > 0 && del11 < 1
%                             del = del11;
%                         else
%                             % Debug
%                             if -(c2+wn*t0*c1) > 0
%                                 disp('Madness!!')
%                             end
%                             disp('No root in (0,1) --> c1-2c2 = 0');        % Not happened so far
%                         end
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
%                         else
%                             disp('Warning: No real root of del in (0,1)!'); % Not happened so far
                        end
                    end
                end
                
                % Now compute wn for the previous del
                k1 = 2/sqrt(1-del^2);
                while(1)
                    num = num+1;
                    % Newton Raphson
                    K = sqrt(w_step_max^2 + wn^2*phi^2 - 2*w_step_max*phi*wn*del);
                    a1 = -phi^2*del*t0;
                    b1 = 2*w_step_max*phi*del^2*t0;
                    c1 = -w_step_max^2*del*t0 + w_step_max*phi*del;
                    d1 = -w_step_max^2;
                    cubic = a1*wn^3 + b1*wn^2 + c1*wn +d1;
                    f_x = (k1*K/(wn*exp(del*wn*t0)))- E;
                    f_dash_x = k1*cubic/(K*wn^2*exp(del*wn*t0));
                    corr = f_x/f_dash_x;
                    if isnan(corr)
                        % Newton Raphson fails when the wn equation has oscillations (cubic) --> Hence going for MATLAB 'solve'
                        eq = 'E1*wn*exp(del*wn*t0) = k1*sqrt(w_step_max^2 + wn^2*phi^2 - 2*w_step_max*phi*wn*del)';
                        eq = subs(eq,{'E1','k1','del','t0','w_step_max','phi'},[E,k1,del,t0,w_step_max,phi]);
                        wn = solve(eq,'wn');
                        wn = subs(wn);
                        % Debug
                        res = E*wn*exp(del*wn*t0) - k1*sqrt(w_step_max^2 + wn^2*phi^2 - 2*w_step_max*phi*wn*del);
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
%                 % Debug
%                 res = E*wn*exp(del*wn*t0) - k1*sqrt(w_step_max^2 + wn^2*phi^2 - 2*w_step_max*phi*wn*del);
%                 if abs(res) > 10^-4
%                     disp('\nSomething is wrong in Newton Raphson!');
%                 end                
                if abs(temp1-del) < 0.0001
                    % Break out of the entire loop
                    break                 
                end            
                temp1 = del;
                % Updating the values of c1 and c2 for the next del computation, since wn has been updated now
                c1 = w_step_max^2 + phi^2*wn^2;
                c2 = wn*phi*w_step_max;                
            end
            % Now del and wn have been computed for a particular fq_step_max and phi
            % Design of kp and ki 
            kp = 2*del*wn/Em;
            ki = (wn^2)/Em;
            tau = kp/ki;              
            Del(x,y) = del;
            Wn(x,y) = wn;
            Kp(x,y) = kp;
            Ki(x,y) = ki;
            Tau(x,y) = tau;
            
            y = y+1;
    end    
x = x+1;
end

% Case when both frequency step and phase jump are zero -> design is not required
Del(x_zero,y_zero) = NaN;
Wn(x_zero,y_zero) = NaN;
Ki(x_zero,y_zero) = NaN;
Kp(x_zero,y_zero) = NaN;
Tau(x_zero,y_zero) = NaN;

w_step_max = xlim(1) : del_x : xlim(2);
fq_step_max = w_step_max/(2*pi);
phi = ylim(1) : del_y : ylim(2);

cnt = 1;
while cnt == 1
    ch = menu('Plot:','Damping ratio, del','Natural frequency, wn','Proportional gain, kp','Integral gain, ki','Time constant, tau');
    switch ch
        case 1
            surf(phi,fq_step_max,real(Del));
            set(gca,'FontWeight','bold')
            grid on
            xlabel('\bf Phase jump (rad)','FontSize',10)
            ylabel('\bf Frequency step (Hz)','FontSize',10)
            zlabel('\bf Damping ratio \delta','FontSize',10)
            title('\bf Optimized value of Damping ratio, \delta','FontSize',12)
        case 2
            surf(phi,fq_step_max,real(Wn));
            set(gca,'FontWeight','bold')
            grid on
            xlabel('\bf Phase jump (rad)','FontSize',10)
            ylabel('\bf Frequency step (Hz)','FontSize',10)
            zlabel('\bf Natural frequency w_n (rad/s)','FontSize',10)
            title('\bf Optimized value of Natural frequency, w_n','FontSize',12)
        case 3
            surf(phi,fq_step_max,real(Kp));
            set(gca,'FontWeight','bold')
            grid on
            xlabel('\bf Phase jump (rad)','FontSize',10)
            ylabel('\bf Frequency step (Hz)','FontSize',10)
            zlabel('\bf Proportional gain k_p','FontSize',10)
            title('\bf Optimized value of Proportional gain, k_p','FontSize',12)
        case 4
            surf(phi,fq_step_max,real(Ki));
            set(gca,'FontWeight','bold')
            grid on
            xlabel('\bf Phase jump (rad)','FontSize',10)
            ylabel('\bf Frequency step (Hz)','FontSize',10)
            zlabel('\bf Integral gain k_i','FontSize',10)
            title('\bf Optimized value of Integral gain, k_i','FontSize',12)
        case 5
            surf(phi,fq_step_max,real(Tau));
            set(gca,'FontWeight','bold')
            grid on
            xlabel('\bf Phase jump (rad)','FontSize',10)
            ylabel('\bf Frequency step (Hz)','FontSize',10)
            zlabel('\bf Time constant \tau (s)','FontSize',10)
            title('\bf Optimized value of Time constant, \tau','FontSize',12)
    end
    cnt = menu('Continue?','Yes','No');
end
