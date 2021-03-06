phi= 0.1;
fq_step_max =10;
del= 0.5;
k2 = (phi/(2*pi*fq_step_max))^2;
k1=2/(sqrt(1-del^2));
syms wn;
fplot('(2.3094/5.0661e-005)^2*exp(-0.5*wn*0.01)*sqrt(1+6.4162e-008*wn^2)', [0,1000*pi]);
hold on;
fplot('wn^2', [0,1000*pi]);
grid on;