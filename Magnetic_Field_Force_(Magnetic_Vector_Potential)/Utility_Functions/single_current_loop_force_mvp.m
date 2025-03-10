function force=single_current_loop_force_mvp(z,R_Coil,R_Mag,Br,I)
% Calculate Force due to a single loop using Magnetic Vector Potential Method
% z is the coordinate of the observation point in Cylindrical coordinate system
% radius_coil is the radius of the single loop
% R_Mag is the radius of the magnet
% Br is the Residual Flux Density of the magnet, unit is Tesla
% I is the current, unit is A
% unit for z,R_Mag and R_Coil is meter

mu0 = 4 * pi * 1e-7; % Permeability of free space
M=Br/mu0;
fun1= @(r) r.*single_loop_bz_mvp(r,z,R_Coil,I);
force=M*2*pi*integral(fun1,0,R_Mag)*1000; % Unit is mN
