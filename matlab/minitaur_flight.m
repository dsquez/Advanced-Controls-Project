function [t,y] = minitaur_flight(tin,yin,params)

t0 = tin(end);
zeta0 = yin(end,1);
psi0 = yin(end,3);
zetad0 = yin(end,2);
psid0 = yin(end,4);

y0 = zeta0*cos(psi0);
x0 = zeta0*sin(psi0);

v0n = zetad0;
v0t = psid0*zeta0;

v0 = rot2(psi0)*[v0t v0n]';

t = t0:0.01:1;

yf = y0 + v0(2).*t -9.8/2.*t.^2;
xf = x0 + v0(1).*t;

endIndex = find(yf<params.zeta_0*cos(params.landing_angle),1);

y = [xf(1:endIndex)', yf(1:endIndex)'];
t = t(1:endIndex);


