% minitaur leg dynamics
function [dy] = minitaur_leg_eom(t,x,params)

dy = zeros(length(x),1);
% x(1) = zeta
% x(2) = zeta_dot
% x(3) = psi
% x(4) = psi_dot

lambda_1 = params.lambda_1;
lambda_2 = params.lambda_2;
% theta_0 = params.theta_0;
g = params.g;
k = params.k;
m = params.m;

% theta_z = params.theta_z;



zeta_0 = params.zeta_0;

dy(1) = x(2);
dy(2) = x(1)*x(4)^2 - g*cos(x(3))...
    + (k/m)...
    *dthetadzeta(x(1),params)...
    *(theta_z(zeta_0) - theta_z(x(1)));
dy(3) = x(4);
dy(4) = -2*x(2)*x(4)/x(1) + g*sin(x(3))/x(1);

end