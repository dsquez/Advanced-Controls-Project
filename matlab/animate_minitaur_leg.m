function animate_minitaur_leg(time,y,FPS,animateFlight,params)
y=real(y);
time_anim = [0:1/FPS:time(end)]; % creates a vector of time at our preferred framerate
l_anim = interp1(time,y(:,1),time_anim);
psi_anim = interp1(time,y(:,3),time_anim);

time_anim = [time_anim time(end)];
l_anim = [l_anim y(1,end)];
psi_anim = [psi_anim y(3,end)];

if animateFlight
    [t_flight, y_flight] = minitaur_flight(time,y,params);
end

flight_time_anim = time(end):1/FPS:t_flight(end);
x_anim = interp1(t_flight,y_flight(:,1),flight_time_anim);
y_anim = interp1(t_flight,y_flight(:,2),flight_time_anim);

% figure()
for iter = 1:numel(time_anim)
    clf
    hold on
    plot([0 l_anim(iter)*sin(psi_anim(iter))],...
        [0 l_anim(iter)*cos(psi_anim(iter))],...
        'k-')
    plot(l_anim(iter)*sin(psi_anim(iter)),...
        l_anim(iter)*cos(psi_anim(iter)),...
        'ro')
    hold off
    axis equal
    axis([-1.5 1.5 -1.5 1.5])
    pause(1/FPS)
    
end

for iter = 1:numel(flight_time_anim)-1
    clf
    hold on
    plot(x_anim(iter),y_anim(iter),'ro')
    hold off
    axis equal
    axis([-1.5 1.5 -1.5 1.5])
    drawnow
    pause(1/FPS)
    
end

clf
hold on
plot(x_anim(end),y_anim(end),'ro')
plot([x_anim(end) x_anim(end)-params.zeta_0*sin(params.landing_angle)],...
    [y_anim(end) 0],'k')
hold off
axis equal
axis([-1.5 1.5 -1.5 1.5])
pause(1/FPS)