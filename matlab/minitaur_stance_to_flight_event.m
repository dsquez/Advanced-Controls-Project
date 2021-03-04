function [value,isterminal,direction] = minitaur_stance_to_flight_event(t,y,params)
rotatedPastMid = y(3)>0;

accels = minitaur_leg_eom(t,y,params);

vert_forces = accels(2)*cos(y(3));

% if (vert_forces < 0 && rotatedPastMid == 1)
%     value = 0;
% else
%     value = 1;
% end

value = vert_forces;


isterminal = 1;
direction = -1;