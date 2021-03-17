function [L2,L2d,t2,t2d] = stance_constraints(L1,L1d,Lsep,t1,t1d)
t1 = 3*pi/2-t1;
L2 = sqrt(L1.^2+Lsep.^2-2*L1.*Lsep.*cos(t1));
t2 = atan2(L1.*sin(t1),L1.*cos(t1)-Lsep);
L2d = (L1.*L1d+L1.*Lsep.*t1d.*sin(t1)-L1d.*Lsep.*cos(t1))./L2;
t2d = (L1.^2.*t1d-L1.*Lsep.*t1d.*cos(t1)+L1d.*Lsep.*sin(t1))...
    ./(L1.*cos(t1)-Lsep+L1.*sin(t1)).^2;

t2 = deg2rad(270) - t2;