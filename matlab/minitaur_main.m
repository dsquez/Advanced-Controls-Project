% minitaur main.m
clc
clear
close all

tspan = [ 0 1 ];

params.theta_0 = pi/4;
params.m = 1.45;
params.k = 8;
params.g = 9.81;
params.lambda_1 = 0.1;
params.lambda_2 = 0.2;

params.zeta_0 = sqrt(params.lambda_2^2 - params.lambda_1^2 ...
    + (params.lambda_1*cos(params.theta_0))^2) ...\
    + params.lambda_1*cos(params.theta_0);

params.theta_z = @(x) acos((x^2 + params.lambda_1^2 - params.lambda_2^2)...
    / (2*params.lambda_1*x));

params.landing_angle = -pi/6;

x0 = [params.zeta_0 -0.1 params.landing_angle 10];

eventFunc = @(t,y) minitaur_stance_to_flight_event(t,y,params);

options = odeset('Events',eventFunc);
time_vec = [];
y_vec = [];
[tout, yout,te,ye,ie] = ode45(@(t,x) minitaur_leg_eom(t,x,params),tspan,x0,options);
[t_flight, y_flight] = minitaur_flight(tout,yout,params);

figure()
subplot(221)
plot(tout,yout(:,1))
title('Length')
subplot(222)
plot(tout,yout(:,2))
title('Length vel')
subplot(223)
plot(tout,yout(:,3))
title('Psi')
subplot(224)
plot(tout,yout(:,4))
title('Psi vel')

figure()
animate_minitaur_leg(tout,yout,300,1,params)
