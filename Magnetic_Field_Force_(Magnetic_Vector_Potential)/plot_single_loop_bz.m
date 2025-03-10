% Must inlcude "Utility_Functions" to Path before run this code
clear
legend_font_size=20;
title_font_size=24;

r=linspace(0,4.8e-3,100); % r is from 0 to 4.8 mm
I=0.33;      % current is 0.33 A
radius=5e-3; % radius of the single coil is 5 mm

% z=0 mm

z=0e-3;      % Axial distance of the point is 0 mm
bz_mvp_1=single_loop_bz_mvp(r,z,radius,I); % unit is T
bz_bsl_1=single_loop_bz_bsl(z,radius,I);   % unit is T

% z=1 mm
z=1e-3;      % Axial distance of the point is 1 mm
bz_mvp_2=single_loop_bz_mvp(r,z,radius,I); % unit is T
bz_bsl_2=single_loop_bz_bsl(z,radius,I);   % unit is T

% z=2 mm
z=2e-3;      % Axial distance of the point is 2 mm
bz_mvp_3=single_loop_bz_mvp(r,z,radius,I); % unit is T
bz_bsl_3=single_loop_bz_bsl(z,radius,I);   % unit is T

% z=3 mm
z=3e-3;      % Axial distance of the point is 3 mm
bz_mvp_4=single_loop_bz_mvp(r,z,radius,I); % unit is T
bz_bsl_4=single_loop_bz_bsl(z,radius,I);   % unit is T

%%
close all
fh1=figure(1);

semilogy(r*1000,bz_mvp_1*1e3,'b-','Linewidth',3,'MarkerSize',4)
hold on
semilogy(0,bz_bsl_1*1e3,'gd','MarkerSize',10,'Linewidth',4)

hold on
semilogy(r*1000,bz_mvp_2*1e3,'b-','Linewidth',3,'MarkerSize',4)
hold on
semilogy(0,bz_bsl_2*1e3,'gd','MarkerSize',10,'Linewidth',4)

semilogy(r*1000,bz_mvp_3*1e3,'b-','Linewidth',3,'MarkerSize',4)
hold on
semilogy(0,bz_bsl_3*1e3,'gd','MarkerSize',10,'Linewidth',4)

semilogy(r*1000,bz_mvp_4*1e3,'b-','Linewidth',3,'MarkerSize',4)
hold on
semilogy(0,bz_bsl_4*1e3,'gd','MarkerSize',10,'Linewidth',4)

grid on
ylabel('Magnetic Field Bz [mT]','FontSize',24,'FontWeight','bold');
xlabel('Radial Coordinate r[mm]','FontSize',24,'FontWeight','bold');
legend('Magnetic Vector Potential Approach','Biot-Savart Law (r=0 mm only)','Location','NorthWest','FontSize',legend_font_size);

title(sprintf('Bz for single current loop, loop radius=%0.1f mm, current=%.2f A',radius*1000,I),'FontSize',title_font_size,'FontWeight','Bold') 
fh1.WindowState = 'maximized';

