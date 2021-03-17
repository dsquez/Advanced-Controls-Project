function dz = slip_2leg_xy(t,z,params)
L1des = 1;
L2des = 1;
L1ddes = 0;
L2ddes = 0;

theta1des = pi;
theta1ddes = 0;
theta2des = -pi;
theta2ddes = 0;

k = params.k;
b = params.b;
kR = params.kR;
bR = params.bR;

Flin1 = -k*(L1-L1des)-b*(L1d-L1ddes);
Flin2 = -k*(L2-L2des)-b*(L2d-L2ddes);

Ftor1 = (kR*(theta1-theta1des)+bR*(theta1d-theta1ddes))/L1;
Ftor2 = (kR*(theta2-theta2des)+bR*(theta2d-theta2ddes))/L2;
dz = zeros(4,1);

dz(1) = z(2);
dz(2) = 1/M*(C1*(Flin1*cos(theta1)+Ftor1*sin(theta1))...
    +C2*(Flin2*cos(theta2)+Ftor2*sin(theta2)));
dz(3) = z(4);
dz(4) = 1/M*(C1*(Flin1*sin(theta1)-Ftor1*cos(theta1))...
    +C2*(Flin2*sin(theta2)-Ftor2*cos(theta2))) + g;


