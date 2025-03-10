function force=multi_current_loop_force_mvp(z,radius_initial,R_Mag,Br,I,dw,Npl,Nl)
% Calculate Force due to a single loop using Magnetic Vector Potential Method
% dw is wire diamter (meter)
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