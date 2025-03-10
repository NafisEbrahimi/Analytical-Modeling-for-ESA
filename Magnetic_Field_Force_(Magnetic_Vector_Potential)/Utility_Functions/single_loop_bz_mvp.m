function bz = single_loop_bz_mvp(r,z,radius_coil,I)
% Calculate Bz of a single loop using Magnetic Vector Potential Method
% r and z are the coordinates of the observation point in Cylindrical coordinate system
% radius_coil is the radius of the single loop
% unit for r,z,and radius_coil is meter
% I is the current, unit is A
% bz is the z componnet of the B field, unit is Tesla

% Parameters
mu0 = 4 * pi * 1e-7; % Permeability of free space (H/m)
R = radius_coil;          % Radius of the single coil

% Compute m
m =((4 * R .* r) ./ ((R + r).^2 + z.^2));

% Elliptic integrals
[K_k,E_k] = ellipke(m); % Complete elliptic integral of the first kind and second kind

% Magnetic field components
common_factor = (mu0 * I) ./ (2 * pi * sqrt((R + r).^2 + z.^2));
bz = common_factor .* (K_k + ((R.^2 - r.^2 - z.^2) ./ ((R - r).^2 + z.^2)) .* E_k);
end