function bz = single_loop_bz_bsl(z,radius_coil,I)
% Calculate Bz of a single loop using Biot-Savart Law, this only applies to
% Bz on the axis(r=0 case)
% z is the coordinate of the observation point in Cylindrical coordinate system
% radius_coil is the radius of the single loop
% unit for z,and radius_coil is meter
% I is the current, unit is A
% bz is the z componnet of the B field, unit is Tesla

% Parameters
mu0 = 4 * pi * 1e-7; % Permeability of free space (H/m)
R = radius_coil;             % Radius of the circular loop (m)

bz = mu0*I*R.^2./(2*(z.^2+R.^2).^(3/2));
end