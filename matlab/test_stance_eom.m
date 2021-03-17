% test double stance
clc
clear
close all

params.m = 1.45;    % mass (kg)
params.k = 100;  % spring constant (N/m)
params.g = 9.81; % gravity (m/s^2)
params.lambda_1 = 0.1; % length of primary link (m)
params.lambda_2 = 0.2; % length of secondary link (m)
params.stance = [ 0 0 ]; % position of stance point
params.br = 0; % damping in linear motion of leg
params.bt = 0; % torsional damping in leg

params.zeta_0 = 0.4; % nominal length of spring
params.landing_angle = pi + pi/6;

params.Lsep = 0.25;
r1 = 0.5;
t1 = params.landing_angle;
eventfunc = @(t,y) double_stance_event(t,y,params);

option = odeset('Events',eventfunc);
odefun = @(t,y) eom_double_stance(t,y,params);
tspan = [ 0 5 ];
y0 = [ r1 0 t1 0];

[tout,yout] = ode45(odefun,tspan,y0,option);

[L2,L2d,t2,t2d] = stance_constraints(yout(:,1),yout(:,2),params.Lsep,yout(:,3),yout(:,4));
y = [yout,L2,t2];

figure()
animate_stance(tout,y,20,params)

figure()
subplot(211)
plot(tout,yout(:,1))

subplot(212)
plot(tout,yout(:,3))
% 
% subplot(223)
% plot(tout,yout(:,5))
% 
% subplot(224)
% plot(tout,yout(:,7))