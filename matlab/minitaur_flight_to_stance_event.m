function [value, isterminal, direction] = minitaur_flight_to_stance_event(t,y,params)

value = y(3) - params.zeta_0*cos(params.landing_angle);
isterminal = 1;
direction = 0;

end