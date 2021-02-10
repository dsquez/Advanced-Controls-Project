% minitaur main.m
clc
clear
close all

tspan = [ 0 1 ];

params.theta_0 = pi/4;
params.m = 1.45;
params.k = 1;
params.g = 9.81;
params.lambda_1 = 0.1;
params.lambda_2 = 0.2;

params.zeta_0 = sqrt(params.lambda_2^2 - params.lambda_1^2 ...
    + (params.lambda_1*cos(params.theta_0))^2) ...\
    + params.lambda_1*cos(params.theta_0);

x0 = [params.zeta_0 -0.1 pi/4 -0.1];
[tout, yout] = ode45(@(t,x) minitaur_leg_eom(t,x,params),tspan,x0);

figure()
subplot(221)
plot(tout,yout(:,1))
subplot(222)
plot(tout,yout(:,2))
subplot(223)
plot(tout,yout(:,3))
subplot(224)
plot(tout,yout(:,4))