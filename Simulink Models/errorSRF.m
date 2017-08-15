% --------------------------------------------------*
% To plot the error e(t) for three cases of del     *
%                                                   *
% Authors: Sambhav R Jain, Pradhyumna Ravikirthi    *
%                                                   *
% --------------------------------------------------*

clc;
clear all;
close all;

% Values for plots
t0 = 0.01;
wn = 100*pi;
% w_step = 2*pi*10;
% phi = 0;
fq_step = input('Frequency step (Hz): ');
phi = input('Phase jump (rad): ');
w_step = 2*pi*fq_step;

ch = 1;
while ch == 1

    choice = menu('Damping ratio:','del < 1','del > 1','del = 1');
    switch choice
        case 1
            del = 0.1;

            wd = wn*sqrt(1-del^2);
            c1 = w_step^2 + phi^2*wn^2;
            c2 = del*wn*phi*w_step;
            gamma = acos(del);

            % Error band, E, at t0
            E = 2*exp(-del*wn*t0)/wd*sqrt(c1-2*c2);
            fprintf('Error band at %f s = %f\n',t0,E);

            t = 0:0.0001:0.1;
            % Positive envelope
            e1 = exp(-del*wn*t)/wd*sqrt(c1-2*c2);
            % Negative envelope
            e2 = -e1;
            % Error with time
            y = exp(-del*wn*t)/wd.*(w_step*sin(wd*t)-phi*wn*sin(wd*t-gamma));

            % Plots
            hold off        % To erase previous history of plots
            
            h = plot(t,e1);
            set(gca,'FontWeight','bold')
            set(h,'LineWidth',2,'LineStyle','--')
            set(h,'Color','k')
            hold on

            k = plot(t,e2);
            set(gca,'FontWeight','bold')
            set(k,'LineWidth',2,'LineStyle','--')
            set(k,'Color','k')
            hold on

            m = plot(t,y);
            set(gca,'FontWeight','bold')
            set(m,'LineWidth',2,'LineStyle','-')
            set(m,'Color','b')
            hold on

            grid on
            xlabel('\bf time (s) \rightarrow','FontSize',11)
            ylabel('\bf e(t) \rightarrow','FontSize',11)
            legend(m,'\delta = 0.1','Location','NorthEast')

        case 2
            del = 2;                
            wd2 = wn*sqrt(del^2-1);
            gamma2 = acosh(del);

            % Error band, E, at t0
            E = exp(-del*wn*t0)/wd2*(w_step*sinh(wd2*t0) - phi*wn*sinh(wd2*t0-gamma2));
            fprintf('Error band at %f s for a del of %d = %f\n',t0,del,E);

            t = 0:0.0001:0.1;             
            y = exp(-del*wn*t)/wd2.*(w_step*sinh(wd2*t)-phi*wn*sinh(wd2*t-gamma2));

            del = 4;        
            wd2 = wn*sqrt(del^2-1);
            gamma2 = acosh(del);

            % Error band, E, at t0
            E = exp(-del*wn*t0)/wd2*(w_step*sinh(wd2*t0) - phi*wn*sinh(wd2*t0-gamma2));
            fprintf('Error band at %f s for a del of %d = %f\n',t0,del,E);

            z = exp(-del*wn*t)/wd2.*(w_step*sinh(wd2*t)-phi*wn*sinh(wd2*t-gamma2));

            % Plots
            hold off        % To erase previous history of plots
            
            h = plot(t,y);
            set(gca,'FontWeight','bold')
            set(h,'LineWidth',2,'LineStyle','--')
            set(h,'Color','b')
            hold on

            k = plot(t,z);
            set(gca,'FontWeight','bold')
            set(k,'LineWidth',2,'LineStyle','-')
            set(k,'Color','r')
               
            xlim([0,0.05])
            grid on
            xlabel('\bf time (s) \rightarrow','FontSize',11)
            ylabel('\bf e(t) \rightarrow','FontSize',11)
            legend('\delta = 2','\delta = 4','Location','NorthEast')   


        case 3
            % del = 1;        
            % Error band, E, at t0
            E = exp(-wn*t0).*(w_step*t0 - phi*(wn*t0-1));
            fprintf('Error band at %f s = %f\n',t0,E);

            t = 0:0.0001:0.1;             
            y = exp(-wn*t).*(w_step*t - phi*(wn*t-1));

            % Plots
            hold off        % To erase previous history of plots
            
            h = plot(t,y);
            set(gca,'FontWeight','bold')
            set(h,'LineWidth',2,'LineStyle','-')
            set(h,'Color','b')
            
            xlim([0,0.05])
            grid on
            xlabel('\bf time (s) \rightarrow','FontSize',11)
            ylabel('\bf e(t) \rightarrow','FontSize',11)
            legend(h,'\delta = 1','Location','NorthEast')

    end
    
   ch = menu('Continue?','Yes','No'); 
end