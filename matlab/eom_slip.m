function dy = eom_slip(t,y,params)
k = params.k;
m = params.m;
br = params.br;
bt = params.bt;
r0 = params.zeta_0;
g = params.g;

ur = params.ur;
ut = params.ut;
dy = zeros(4,1);

dy(1) = y(2);
dy(2) = y(1)*y(4)^2 - k/m*(y(1)-r0)...
    +cos(y(3)) - br*y(2) + ur;
dy(3) = y(4);
dy(4) = -g/y(1)*sin(y(3))...
    -2*y(2)*y(4)/y(1) - bt*y(4) + ut;