% ----------------------------------------------------------------------*
% Plot program (Step 3) for PLL comparison                              *
%                                                                       *
% Sambhav R Jain (sambhav.eee@gmail.com)                                *
% Pradhyumna Ravikirthi (pradhyumnarao@gmail.com)                       *
% NIT Trichy                                                            *
% Feb 2012                                                              *
% ----------------------------------------------------------------------*

% Plots

ts = 1e-4;          % default Matlab sampling time
Tp = 20e-3;         % time period of a cycle
band = cycles/4;    % cycle band around fault
d = band*Tp;

%%%%%%%%%%%%%%%%%%%%%
% Color Codes       %
% r–red             %
% g–green           %
% b–blue            %
% c–cyan            %
% m–magenta         %
% y–yellow          %
% k–black           %
% w–white           %
%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Line Style Codes            %
% solid line (-)              %
% dashed line (--)            %
% dotted line (:)             %
% dotted-dashed line (-.)     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \bf  ---> Bold Font

strtitle = [{'\bf Unbalanced Grid'},{'\bf Line to Ground Fault'},{'\bf Harmonics'},{'\bf Harmonics and Unbalanced Grid'},{'\bf Phase Jump'},{'\bf Frequency Excursion'}];
strlegend = [{'\bf SRF'},{'\bf DDSRF'},{'\bf DSOGI'},{'\bf MCCF'},{'\bf DiscSRF'}];

ch1 = 1;

while(ch1 == 1)
    
while(1)
fprintf('\nChoose the PLL algorithms to be compared:\n1. SRF\n2. DDSRF\n3. DSOGI\n4. MCCF\n5. Discrete SRF\nE.g. [1,3] would mean SRF and DSOGI comparisons.\nYour choice: ');
comp = input('');
if max(comp) <= 5 && min(comp) >= 1
    break;
end
fprintf('\nPlease enter a valid choice!\n');
end

legendname = strlegend(comp);
width = [2;2.5;2.5;2.5;2.5];    % Widths for 5 PLLs in the respective order
widthnew = num2cell(width(comp));
lstyle = {'-';'-';'-';'-';'-'};
lstylenew = lstyle(comp);
clr = {'k';'b';[0,0.5,0];'r';'c'};
clrnew = clr(comp);

ch2 = 1;

while(ch2 == 1)
i = menu('Imperfection:','Unbalance','LG Fault','Harmonics','Harmonics and Unbalance','Phase Jump','Frequency Excursion');
j = menu('Choose:','Space vector v_q','Voltage error v_d','Phase error e(t)','Estimated angle');
    
f_no = 2*i;

xmin = f_no*cycles*Tp - d;
xmax = xmin + cycles*Tp + 2*d;
pt1 = [0.259882869692533,0.774524158125915];
pt2 = [0.905441717791411,0.906441717791411];

% Grid
ymin1 = min(min(Grid)) - 0.1*abs(min(min(Grid)));
ymax1 = max(max(Grid)) + 0.1*abs(max(max(Grid)));
subplot(2,1,1)
h = plot(time,Grid);
set(gca,'FontWeight','bold')
set(h,{'LineWidth'},{2;2;2},{'LineStyle'},{'-';'-';'-'})
set(h,{'Color'},{'r';[0.75,0.75,0];'b'})
annotation('doublearrow',pt1,pt2,'LineWidth',1.5)
axis([xmin,xmax,ymin1,ymax1])
grid on
xlabel('\bf time (s) \rightarrow','FontSize',11)
ylabel('\bf 3-phase voltages (V) \rightarrow' , 'FontSize',11)
legend(h,'\bf R','\bf Y','\bf B','Location','SouthEast')
title(strtitle(i),'FontSize',12)

switch j
    case 1
        % v_q
        ymin2 = min(min(v_q(xmin/ts:xmax/ts,comp))) - 0.05*abs(min(min(v_q(xmin/ts:xmax/ts,comp))));
        ymax2 = max(max(v_q(xmin/ts:xmax/ts,comp))) + 0.05*abs(max(max(v_q(xmin/ts:xmax/ts,comp))));
        subplot(2,1,2)
        h = plot(time,v_q(:,comp));
        set(gca,'FontWeight','bold')
        set(h,{'LineWidth'},widthnew,{'LineStyle'},lstylenew)
        set(h,{'Color'},clrnew)
        axis([xmin,xmax,ymin2,ymax2])
        grid on
        xlabel('\bf time (s) \rightarrow','FontSize',11)
        ylabel('\bf v_q (V) \rightarrow','FontSize',11)
        legend(h,legendname,'Location','SouthEast')
        title('\bf Space vector v_q','FontSize',12)
        
    case 2
        % v_d
        ymin2 = min(min(v_d(xmin/ts:xmax/ts,comp))) - 0.05*abs(min(min(v_d(xmin/ts:xmax/ts,comp))));
        ymax2 = max(max(v_d(xmin/ts:xmax/ts,comp))) + 0.04*abs(max(max(v_d(xmin/ts:xmax/ts,comp))));
        subplot(2,1,2)
        h = plot(time,v_d(:,comp));
        set(gca,'FontWeight','bold')
        set(h,{'LineWidth'},widthnew,{'LineStyle'},lstylenew)
        set(h,{'Color'},clrnew)
        axis([xmin,xmax,ymin2,ymax2])
        grid on
        xlabel('\bf time (s) \rightarrow','FontSize',11)
        ylabel('\bf v_d (V) \rightarrow','FontSize',11)
        legend(h,legendname,'Location','SouthEast')
        title('\bf Voltage error v_d','FontSize',12)
    
    case 3
        % Phase Error
        perr = v_d/Em;
        ymin2 = min(min(perr(xmin/ts:xmax/ts,comp))) - 0.05*abs(min(min(perr(xmin/ts:xmax/ts,comp))));
        ymax2 = max(max(perr(xmin/ts:xmax/ts,comp))) + 0.05*abs(max(max(perr(xmin/ts:xmax/ts,comp))));
        subplot(2,1,2)
        h = plot(time,perr(:,comp));
        set(gca,'FontWeight','bold')
        set(h,{'LineWidth'},widthnew,{'LineStyle'},lstylenew)
        set(h,{'Color'},clrnew)
        axis([xmin,xmax,ymin2,ymax2])
        grid on
        xlabel('\bf time (s) \rightarrow','FontSize',11)
        ylabel('\bf e(t) \rightarrow','FontSize',11)
        legend(h,legendname,'Location','SouthEast')
        title('\bf Phase error e(t)','FontSize',12)
        
    case 4
        % Theta Estimated
        ymin2 = min(min(theta_est(xmin/ts:xmax/ts,comp))) - 0.05*abs(min(min(theta_est(xmin/ts:xmax/ts,comp))));
        ymax2 = max(max(theta_est(xmin/ts:xmax/ts,comp))) + 0.05*abs(max(max(theta_est(xmin/ts:xmax/ts,comp))));
        subplot(2,1,2)
        h = plot(time,theta_est(:,comp));
        set(gca,'FontWeight','bold')
        set(h,{'LineWidth'},widthnew,{'LineStyle'},lstylenew)
        set(h,{'Color'},clrnew)
        axis([xmin,xmax,ymin2,ymax2])
        grid on
        xlabel('\bf time (s) \rightarrow','FontSize',11)
        ylabel('\bf \theta_{est}(t) \rightarrow','FontSize',11)
        legend(h,legendname,'Location','SouthEast')
        title('\bf Estimated angle, \theta_{est}','FontSize',12)        
end

ch2 = menu('Continue?','Yes','No');
end

ch1 = menu('Move on to another comparison?','Yes','No');
end
