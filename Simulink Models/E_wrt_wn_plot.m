x= 0.907642;
wn =200:.1:600;
c1= w_step_max^2 + phi^2*wn.^2;
c2=wn*phi*w_step_max;
E = (2*exp(-x*wn*t0)./(wn*sqrt(1-x.^2))).*sqrt(c1-2*c2*x);
plot(wn,E);
grid on;