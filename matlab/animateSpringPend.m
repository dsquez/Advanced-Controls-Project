function animateSpringPend(t,y,FPS,plottitle)

time_anim = t(1):1/FPS:t(end);
r_anim = interp1(t,y(:,1),time_anim);
theta_anim = interp1(t,y(:,3),time_anim);

for iter = 1:length(time_anim)
    
    clf
    axis([-0.4 0.4 -0.1 0.8])
    
    hold on
%     title(plottitle)
    plot([0 r_anim(iter)*sin(theta_anim(iter))],...
        [0 -r_anim(iter)*cos(theta_anim(iter))],...
        'k-','Markersize',3)
    plot(r_anim(iter)*sin(theta_anim(iter)),...
        -r_anim(iter)*cos(theta_anim(iter)),...
        'ro','MarkerSize',10)
    hold off
    
    pause(1/FPS)
    
end