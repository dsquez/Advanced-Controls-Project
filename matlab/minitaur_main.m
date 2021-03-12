% minitaur main.m
clc
clear
close all

tspan = [ 0 1 ];

% params.theta_0 = pi/4;
params.m = 1.45;
params.k = 8;
params.g = 9.81;
params.lambda_1 = 0.1;
params.lambda_2 = 0.2;
params.stance = [ 0 0 ];
params.br = 0;
params.bt = 0;

params.zeta_0 = 0.25;
% params.zeta_0 = sqrt(params.lambda_2^2 - params.lambda_1^2 ...
%     + (params.lambda_1*cos(params.theta_0))^2) ...\
%     + params.lambda_1*cos(params.theta_0);

% params.theta_z = @(x) acos((x^2 + params.lambda_1^2 - params.lambda_2^2)...
%     / (2*params.lambda_1*x));

params.landing_angle = pi + pi/6;

params.ur = 0;
params.ut = 0;


eventStance = @(t,y) minitaur_stance_to_flight_event(t,y,params);
eventFlight = @(t,y) minitaur_flight_to_stance_event(t,y,params);

optionsStance = odeset('Events',eventStance);
optionsFlight = odeset('Events',eventFlight);

current_state_zp = [params.zeta_0 -0.5 params.landing_angle -6];
current_time = 0;

t_vec = [];
y_vec = [];

for i = 1:2
    [tout, yout,te,ye,ie] = ode45(@(t,x) eom_slip(t,x,params),...
        [current_time current_time+10],current_state_zp,optionsStance);
    
    params.stance = [params.stance; params.stance(end,:)];
    current_time = tout(end);
    current_state_xy = convert_state_to_xy(yout(end,:),params);
    
    y_vec = [ y_vec; yout ones(length(yout(:,1)),1)];
    t_vec = [ t_vec; tout ];
    
    [tout,yout,te,ye,ie] = ode45(@(t,x) minitaur_flight_eom(t,x,params),...
        [current_time current_time+10],current_state_xy,optionsFlight);
    
    params.stance = [params.stance;...
        yout(end,1)-params.zeta_0*sin(params.landing_angle),...
        0 ];
    params.stance = real(params.stance);
    
    current_time = tout(end);
    current_state_zp = convert_state_to_zp(yout(end,:),params);
    
    y_vec = [ y_vec; yout zeros(length(yout(:,1)),1)];
    t_vec = [ t_vec; tout ];
    
end

data_sorted = sort_data(t_vec,y_vec);
animate_minitaur_leg(data_sorted,200,params);
% figure()
% plot(data_sorted(3).t,data_sorted(3).y(:,3))


function state_xy = convert_state_to_xy(z,params)

stance_x = params.stance(end,1);
stance_y = params.stance(end,2);

x = stance_x + z(1)*sin(z(3));
y = stance_y - z(1)*cos(z(3));

dx = z(2)*sin(z(3)) + z(1)*z(4)*cos(z(3));
dy = z(2)*cos(z(3)) + z(1)*z(4)*sin(z(3));

state_xy = [ x dx y dy ];

end

function state_zp = convert_state_to_zp(z,params)
if not(isreal(z))
    z=real(z);
end
stance_x = params.stance(end,1);
stance_y = params.stance(end,2);

zeta = sqrt((z(1)-stance_x)^2 + (z(3) - stance_y)^2);
psi = atan2((z(3) - stance_y),(z(1)-stance_x)) + pi/2;

vec_along_leg = [(z(1)-stance_x) (z(3) - stance_y)];
vec_along_leg = vec_along_leg ./ norm(vec_along_leg);
zetad = dot([z(2) z(4)], vec_along_leg);

vec_perp_leg = rot2(-pi/2)*vec_along_leg';

psid = dot([z(2) z(4)], vec_perp_leg) / z(1);

state_zp = [ zeta zetad psi psid ];

end
