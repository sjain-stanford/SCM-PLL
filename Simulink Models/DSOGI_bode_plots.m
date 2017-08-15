%bode plot DSOGI ---> SOGI-QSG scheme
clear all
close all
clc
k = [0.1,1,4];
i=1;
w_dash = 2*pi*50;
while(i<=3)
    sys =tf([k(i)*w_dash,0],[1,k(i)*w_dash,(w_dash)^2]);
    bode(sys)
    hold on
    i =i+1;
end
grid on
atemp = input('press any key to continue');
%bode plot DSOGI ---> SOGI-QSG scheme
k = [0.1,1,4];
i=1;
w_dash = 2*pi*50;
while(i<=3)
    sys =tf([k(i)*(w_dash)^2],[1,k(i)*w_dash,(w_dash)^2]);
    bode(sys)
    hold on
    i =i+1;
end
grid on
