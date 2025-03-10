function bz = multi_loop_bz_bsl(z,radius_initial,I,dw,Npl,Nl)
% Calculate Bz of a multi loop using Biot-Savart Law
% z is the coordinate of the observation point in Cylindrical coordinate system
% radius_initial is the radius of the initial layer
% unit for z,and radius is meter
% I is the current, unit is A
% bz is the z componnet of the B field, unit is Tesla
% dw is wire diamter (meter)
% Npl is number of turns per layer
% Nl  is number of layers

bz=0;
for m=1:Nl
    Rm=radius_initial+(m-1)*dw+dw/2; % Radius of the loop for layer m
    for n=1:Npl
        zz=z+(Npl-1)/2*dw-(n-1)*dw;
        bz=bz+single_loop_bz_bsl(zz,Rm,I);
    end
end

end