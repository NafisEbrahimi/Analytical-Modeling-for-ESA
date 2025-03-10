function force=multi_current_loop_force_mvp(z,radius_initial,R_Mag,Br,I,dw,Npl,Nl)
% Calculate Force due to a  multi-loop coil using Magnetic Vector Potential Method
% z is the coordinate of the observation point in Cylindrical coordinate system
% radius_initial is the initial radius of the coil for the inner most layer
% R_Mag is the radius of the magnet
% Br is the Residual Flux Density of the magnet, unit is Tesla
% I is the current, unit is A
% dw is wire diamter
% unit for z,R_Mag,dw and radius_initial is meter
% Npl is number of turns per layer
% Nl  is number of layers
force=0;
for m=1:Nl
    Rm=radius_initial+(m-1)*dw+dw/2; % Radius of the loop for layer m
    for n=1:Npl
        zz=z+(Npl-1)/2*dw-(n-1)*dw;
        force=force+single_current_loop_force_mvp(zz,Rm,R_Mag,Br,I);
    end
end