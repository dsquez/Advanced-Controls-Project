function [t,y] = minitaur_flight(tin,yin,params)

toff = tin(end);
t0 = 0;
zeta0 = yin(end,1);
psi0 = yin(end,3);
zetad0 = yin(end,2);
psid0 = yin(end,4);

y0 = zeta0*cos(psi0);
x0 = zeta0*sin(psi0);

% v0t = zetad0;
% v0n = psid0*zeta0;
% 
% v0 = rot2(psi0)*[v0t v0n]';
zetadx = zetad0*cos(psi0);
zetady = zetad0*sin(psi0);

vnx = psid0*zeta0*cos(pi/2 - psi0);
vny = psid0*zeta0*sin(pi/2 - psi0);

v0 = [ zetadx+vnx, zetady+vny ];
t = t0:0.001:1;

yf = y0 + v0(2).*(t+toff) -9.8/2.*(t+toff).^2;
xf = x0 + v0(1).*t;

vfy = v0(2) - 9.8*(t+toff);


endIndex = find(yf<params.zeta_0*cos(params.landing_angle),1);
% endIndex = 10

y = [xf(1:endIndex)', yf(1:endIndex)'];
t = t(1:endIndex);
t = t+toff;
vfy = vfy(endIndex);

vf = [ v0(1) vfy ];

% yd_end =  



