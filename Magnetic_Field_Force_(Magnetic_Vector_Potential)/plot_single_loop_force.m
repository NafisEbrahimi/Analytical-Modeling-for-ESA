% Must inlcude "Utility_Functions" to Path before run this code
clear
legend_font_size=20;
title_font_size=24;
tic
load('Utility_Functions\Force_Single_COMSOL.mat');
force_comsol=0.33*transpose(comsol_data(:,2))*1000; % force from COMSOL simulation, unit is mN
% z is position of the permanent magnet
% z=0 mm means the edge of the magnet is same plane of the current loop
% Since the height of the magnet is 20 mm, z =-10 mm means the center of the magnet is in the same plane of the current loop; 
% z=+10 mm means the edge of the magnet is 10 mm away from the current loop

z_comsol=transpose(comsol_data(:,1))*1e-3;  % z for comsol simulation
z=linspace(-10,10,2001)*1e-3;                   % z for matlab calculation simulation, same range for z_comsol, but with finer step 
R_Coil=5e-3; % radius of the loop (meter)
Gap=0.2e-3;  % air gap  (meter)
R_Mag=R_Coil-Gap; % radius of the permanent magnet  (meter)
I=0.33;       % loop current (A)
Br=1.0;      % remanence of the permanent magnet (Tesla)
Height_Mag=20e-3; % height of the permanent magnet (meter)

force_mvp=zeros(1,length(z)); % force from Magnetic Vector Potential Method
force_bsl=zeros(1,length(z)); % force from Biot-Savart Law Approximation
for m=1:length(z)
    force_mvp(m)=single_current_loop_force_mvp(z(m),R_Coil,R_Mag,Br,I)-single_current_loop_force_mvp((z(m)+Height_Mag),R_Coil,R_Mag,Br,I);
    force_bsl(m)=single_current_loop_force_bsl(z(m),R_Coil,R_Mag,Br,I)-single_current_loop_force_bsl((z(m)+Height_Mag),R_Coil,R_Mag,Br,I);
end
%%
close all
fh1=figure(1);
plot(z*1000,force_mvp,'b-','Linewidth',4,'MarkerSize',4)
hold on
plot(z_comsol*1000,force_comsol,'rsquare','Linewidth',3,'MarkerSize',8)
hold on
ylabel('Force [mN]');
xlabel('Relative displacement z [mm]');
set(gca,'FontSize',20)
legend('Magnetic Vector Potential Approach','COMSOL Simulation','Location','NorthEast','FontSize',legend_font_size);
title(sprintf('Force from a single current loop, loop radius=%0.1f mm, current=%.2f A, magnet height=%0.1f mm, air gap=%0.1f mm, Br=%0.1f T',R_Coil*1000,I,Height_Mag*1000,Gap*1000,Br),'FontSize',title_font_size,'FontWeight','Bold') 
grid on
fh1.WindowState = 'maximized';
