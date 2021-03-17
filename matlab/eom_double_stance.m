function dy = eom_double_stance(t,y,params)
% y = [ r1 r1dot r2 r2dot theta1 theta1dot theta2 theta2dot ]
r1 = y(1);
r1dot = y(2);

t1 = y(3);
t1dot = y(4);


m = params.m;
k = params.k;
g = params.g;
r0 = params.zeta_0;

ur1 = 0;
ur2 = 0;
ut1 = -1;
ut2 = 1;
[r2,r2dot,t2,t2dot] = stance_constraints(r1,r1dot,params.Lsep,t1,t1dot);
% dy = [ r1dot r1ddot r2dot r2ddot theta1dot theta1ddot theta2dot
% theta2ddot ]
dy(1) = r1dot;
dy(2) = ur1/m + k/m*(r0-r1) + ut2/(m*r2) - g*sin(t2);

dy(3) = t1dot;
dy(4) = ut1/(m*r1^2) - 1/(m*r1)*(ur2+k*(r0-r2))*sin(t1-t2)+(g/r1)*sin(t1);


dy = dy';