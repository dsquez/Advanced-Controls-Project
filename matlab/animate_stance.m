function animate_stance(t,y,FPS,params)
stance1 = [ 0 0 ];
stance2 = stance1-[params.Lsep 0];
t_anim = t(1):1/FPS:t(end);
r1_anim = interp1(t,y(:,1),t_anim);
r2_anim = interp1(t,y(:,5),t_anim);
t1_anim = interp1(t,y(:,3),t_anim);
t2_anim = interp1(t,y(:,6),t_anim);

for iter = 1:length(t_anim)
    clf
    hold on
    plot([stance1(1) r1_anim(iter)*sin(t1_anim(iter))],...
        [stance1(2) -r1_anim(iter)*cos(t1_anim(iter))],'k')
    plot([stance2(1) r2_anim(iter)*sin(t2_anim(iter))+stance2(1)],...
        [stance2(2) -r2_anim(iter)*cos(t2_anim(iter))],'b')
    
    hold off
%     axis equal
    axis([-0.4 0.4 -0.1 0.8])
    pause(1/FPS)
end
