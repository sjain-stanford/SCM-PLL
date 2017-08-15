% --------------------------------------------------*
% To plot the comparisons in Approach 1, Approach 2 *
%                                                   *
% Authors: Sambhav R Jain, Pradhyumna Ravikirthi    *
%                                                   *
% --------------------------------------------------*

clc;
clear all;
close all;

Em = -230*sqrt(2);
% t0 = 0.01;
% fq_step_max = 10;

t0 = input('Desired settling time, t0 (s): ');
fq_step_max = input('Max. allowable frequency step (Hz): ');

ch = menu('Approach to compare:','Approach 1 (quantify error)','Approach 2 (optimize del)','Approach 3 (optimize both)');

switch(ch)
    case 1
        fprintf('\nApproach 1 (quantify error)\n');
%         E = 0.02;
        E = input('Enter the max. permissible error band, E: ');
        E_N = E/(2*pi*fq_step_max);
        del = 0:0.001:0.999;
        
        % simplified version of [wn] = solve('E_N*wn*sqrt(1-del^2) = 2*exp(-del*wn*t0)')
        wn = lambertw(0, (2*del*t0)./(E_N*(1 - del.^2).^(1/2)))./(del*t0);
        kp = 2.*del.*wn/Em;
        ki = (wn.^2)./Em;
        Tau = kp./ki; 
        
        subplot(2,2,1)
        a = plot(del,kp);
        set(gca,'FontWeight','bold')
        set(a,'LineWidth',2,'LineStyle','-')
        set(a,'Color',[0,0.5,0])
        axis([0,1.1,-3.5,0])
        grid on
        xlabel('\bf Damping constant, \delta \rightarrow','FontSize',10)
        ylabel('\bf Proportional gain, K_p \rightarrow' , 'FontSize',10)
        
        subplot(2,2,2)
        b = plot(del,ki);
        set(gca,'FontWeight','bold')
        set(b,'LineWidth',2,'LineStyle','-')
        set(b,'Color','b')
        axis([0,1.1,-6000,0])
        grid on
        xlabel('\bf Damping constant, \delta \rightarrow','FontSize',10)
        ylabel('\bf Integral gain, K_i \rightarrow' , 'FontSize',10)
        
        subplot(2,2,3)
        c = plot(del,wn);
        set(gca,'FontWeight','bold')
        set(c,'LineWidth',2,'LineStyle','-')
        set(c,'Color','k')
        axis([0,1.1,0,2500])
        grid on
        xlabel('\bf Damping constant, \delta \rightarrow','FontSize',10)
        ylabel('\bf Natural frequency, \omega_n (rad/s) \rightarrow' , 'FontSize',10)
        
        subplot(2,2,4)
        d = plot(del,Tau.*1e3);
        set(gca,'FontWeight','bold')
        set(d,'LineWidth',2,'LineStyle','-')
        set(d,'Color','r')
        axis([0,1.1,0,5])
        grid on
        xlabel('\bf Damping constant, \delta \rightarrow','FontSize',10)
        ylabel('\bf Time constant, \tau (ms) \rightarrow' , 'FontSize',10)
        
    case 2
        fprintf('\nApproach 2 (optimize del)\n');
        wn = 0:0.1:1500;
        del = (-1+sqrt(1+4*wn.^2*t0^2))./(2*wn*t0);
        kp = 2.*del.*wn/Em;
        ki = (wn.^2)./Em;
        Tau = kp./ki;
        
        subplot(2,2,1)
        a = plot(wn,kp);
        set(gca,'FontWeight','bold')
        set(a,'LineWidth',2,'LineStyle','-')
        set(a,'Color',[0,0.5,0])
        axis([0,1500,-10,1])
        grid on
        xlabel('\bf Natural frequency, \omega_n (rad/s) \rightarrow','FontSize',10)
        ylabel('\bf Proportional gain, K_p \rightarrow' , 'FontSize',10)
        
        subplot(2,2,2)
        b = plot(wn,ki);
        set(gca,'FontWeight','bold')
        set(b,'LineWidth',2,'LineStyle','-')
        set(b,'Color','b')
        axis([0,1500,-7000,500])
        grid on
        xlabel('\bf Natural frequency, \omega_n (rad/s) \rightarrow','FontSize',10)
        ylabel('\bf Integral gain, K_i \rightarrow' , 'FontSize',10)
        
        subplot(2,2,3)
        c = plot(wn,del);
        set(gca,'FontWeight','bold')
        set(c,'LineWidth',2,'LineStyle','-')
        set(c,'Color','k')
        axis([0,1500,0,1.1])
        grid on
        xlabel('\bf Natural frequency, \omega_n (rad/s) \rightarrow','FontSize',10)
        ylabel('\bf Damping constant, \delta \rightarrow' , 'FontSize',10)
        
        subplot(2,2,4)
        d = plot(wn,Tau.*1e3);
        set(gca,'FontWeight','bold')
        set(d,'LineWidth',2,'LineStyle','-')
        set(d,'Color','r')
        axis([0,1500,0,22])
        grid on
        xlabel('\bf Natural frequency, \omega_n (rad/s) \rightarrow','FontSize',10)
        ylabel('\bf Time constant, \tau (ms) \rightarrow' , 'FontSize',10)
   
    % Yet to do Approach 3
    case 3
                
 end