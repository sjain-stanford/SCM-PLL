% Plots

ts = 1e-4;      % default Matlab sampling time
Tp = 20e-3;     % time period of a cycle
band = 2.5;     % cycle band around fault
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

str = [{'Unbalanced Grid'},{'Line to Ground Fault'},{'Frequency Excursion'},{'Harmonics'},{'Harmonics and Unbalanced Grid'}];

% 1 - Unbalance (Fault no. 2)
f_no = 2;
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
set(h,{'LineWidth'},{2.2;2.5;2.8},{'LineStyle'},{'-';'--';':'})
set(h,{'Color'},{'r';[0.75,0.75,0];'b'})
annotation('doublearrow',pt1,pt2,'LineWidth',1.5)
axis([xmin,xmax,ymin1,ymax1])
grid on
xlabel('\bf time (s) \rightarrow','FontSize',10)
ylabel('\bf phase voltage (V) \rightarrow' , 'FontSize',10)
legend(h,'\bf R','\bf Y','\bf B','Location','SouthEast')
title('\bf Unbalanced Grid','FontSize',12)

% v_q
ymin2 = min(min(v_q(xmin/ts:xmax/ts,1:4))) - 0.05*abs(min(min(v_q(xmin/ts:xmax/ts,1:4))));
ymax2 = max(max(v_q(xmin/ts:xmax/ts,1:4))) + 0.05*abs(max(max(v_q(xmin/ts:xmax/ts,1:4))));
subplot(2,1,2)
h = plot(time,v_q(:,1:4));
set(gca,'FontWeight','bold')
set(h,{'LineWidth'},{2;2.5;2.5;2.5},{'LineStyle'},{'-';'-';'-';'-'})
set(h,{'Color'},{'k';'b';[0,0.5,0];'r'})
axis([xmin,xmax,ymin2,ymax2])
grid on
xlabel('\bf time (s) \rightarrow','FontSize',10)
ylabel('\bf v_q (V) \rightarrow','FontSize',10)
legend(h,'\bf SRF','\bf DDSRF','\bf DSOGI','\bf MCCF','\bf DiscSRF','Location','SouthEast')
title('\bf Space Vector','FontSize',12)

% temp = menu('Press to continue','Ok');

% xmin = (t1-d)*ts;
% xmax = (t2+d)*ts;

% v_q
% subplot(2,1,1);
% plot(time(t1-d:t2+d),Grid(t1-d:t2+d,:));
% axis([xmin,xmax,ymin,ymax])
% grid on;
% subplot(2,1,2);
% plot(time(t1-d:t2+d),v_q(t1-d:t2+d,:));
% axis([xmin,xmax,ymin,ymax])
% grid on;
% 
% temp = menu('Press to continue','Ok');
% %

