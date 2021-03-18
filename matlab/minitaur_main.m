% minitaur main.m
clc
clear
close all

tspan = [ 0 1 ];

params.m = 1.45;
params.k = 8;
params.g = 9.81;
params.lambda_1 = 0.1;
params.lambda_2 = 0.2;
params.stance = [ 0 0 ];
params.br = 0;
params.bt = 0;

params.zeta_0 = 0.25;

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
figure(1)
animate_minitaur_leg(data_sorted,200,params, 0.35);

for k = 1:numel(data_sorted)
    t = data_sorted(k).t;
    y = data_sorted(k).y(:,1:4);
    mode = data_sorted(k).y(1,5);
    
    fall_index = find(y(:,3) < 0, 1); % find index at which y(:,3) goes below zero
    robot_fallen = fall_index < numel(y(:,3)); % robot fell through the floor?
    if robot_fallen
        if fall_index == 1
            return
        end
        t = t(1:fall_index);
        y = y(1:fall_index, :);
    end
        
    figure(k+1)
    if mode == 1 % stance
        sgtitle("Mode: Stance");
        subplot(2,1,1)
        plot(y(:,1), y(:,2))
        xlabel('r')
        ylabel('dr')
        subplot(2,1,2)
        plot(y(:,3), y(:,4)) 
        xlabel('theta')
        ylabel('dtheta')
    else
        sgtitle("Mode: Flight");
        subplot(2,1,1)
        plot(y(:,1), y(:,2))
        xlabel('x')
        ylabel('dx')
        subplot(2,1,2)
        plot(y(:,3), y(:,4)) 
        xlabel('y')
        ylabel('dy')
    end
    saveas(gcf, ['plots-anim' filesep char(k+48) '.png']);
    
    if robot_fallen
        break
    end
end

% state_xy = zeros(size(y_vec, 1), 4);
% for k = 1:size(y_vec,1)
%     state = y_vec(k,1:4);
%     mode = y_vec(k,5);
%     if mode == 1 % stance
%         state_xy(k,:) = convert_state_to_xy(state, params);
%     else % flight
%         state_xy(k,:) = state;
%     end
% end


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

function R = rot2(theta)
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
end
