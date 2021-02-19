function animate_minitaur_flight(time,y,FPS,params)
y=real(y);
time_anim = [0:1/FPS:time(end)]; % creates a vector of time at our preferred framerate
x_anim = interp1(time,y(:,1),time_anim);
y_anim = interp1(time,y(:,2),time_anim);

% figure()
for iter = 1:numel(time_anim)-1
    clf
    hold on
    plot(x_anim(iter),y_anim(iter),'ro')
    hold off
    axis equal
    axis([-1.5 1.5 -1.5 1.5])
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