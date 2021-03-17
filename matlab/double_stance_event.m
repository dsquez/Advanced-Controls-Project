function [value,isterminal,direction] = double_stance_event(t,y,params)
[r2,~,~,~] = stance_constraints(y(1),y(2),params.Lsep,y(3),y(4));
value = r2 - params.zeta_0;
isterminal = 1;
direction = 1;