function dz = minitaur_flight_eom(t,z,params)

dz = zeros(4,1);

dz(1) = z(2);
dz(2) = 0;
dz(3) = z(4);
dz(4) = -params.g;

end