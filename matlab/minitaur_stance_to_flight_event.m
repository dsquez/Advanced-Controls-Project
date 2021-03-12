function [value,isterminal,direction] = minitaur_stance_to_flight_event(t,y,params)
rotatedPastMid = y(3)<pi;

accels = eom_slip(t,y,params);

% vert_forces = -accels(2)*cos(y(3));
% vert_forces = accels(2);

% if (vert_forces < 0 && rotatedPastMid == 1)
%     value = 0;
% else
%     value = 1;
% end

value = y(1) - params.zeta_0;


isterminal = 1;
direction = 0;