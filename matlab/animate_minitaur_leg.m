function y = animate_minitaur_leg(data,FPS,params)

for iter = 1:numel(data)
    y=real(data(iter).y);
    time = data(iter).t;
    
    time_anim = time(1):1/FPS:time(end); % creates a vector of time at our preferred framerate
    if data(iter).y(1,5) == 1 % if we are in stance
        l_anim = interp1(time,y(:,1),time_anim);
        psi_anim = interp1(time,y(:,3),time_anim);
        
        x_stance_anim = l_anim.*sin(psi_anim)+params.stance(iter,1);
        y_stance_anim = -l_anim.*cos(psi_anim)+params.stance(iter,2);
        
        for jiter = 1:numel(time_anim)
            clf
            hold on
            plot([params.stance(iter,1) x_stance_anim(jiter)],...
                [params.stance(iter,2) y_stance_anim(jiter)],...
                'k-')
            plot(x_stance_anim(jiter),...
                y_stance_anim(jiter),...
                'ro')
            hold off
            axis equal
            axis([-0.5 1 -0.1 0.5])
            pause(1/FPS)
            
        end
        
    else % if we are in flight
        x_anim = interp1(time,y(:,1),time_anim);
        y_anim = interp1(time,y(:,3),time_anim);
        
        
        for jiter = 1:numel(time_anim)
            clf
            hold on
            plot(x_anim(jiter),...
                y_anim(jiter),...
                'ro')
            hold off
            axis equal
            axis([-0.5 1 -0.1 0.5])
            pause(1/FPS)
            
        end
        
    end
end
end
        
