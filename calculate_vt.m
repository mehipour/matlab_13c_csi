function z = calculate_vt(set_vt,set_dp)
%
% calculates the delivered tidal volume in milliliters to the rat in HUPC using the small
% animal ventilator made by Harvard instruments.
%
% synatax:
% desired_vt = calculated_vt(set_vt,driving_pressure)
% written by MP on 9/1/2016

plot_linear_fits = 0;

% driving pressure in cmH2O
dp = [7,12,19,25];

% set tidal volume in ml
setvt = [2,2.5,3,3.5,4,4.5,5];

% linearly interpolate the missing values
a1 = linearfit([2,3,4,5],[1,2,3.1,4.1],plot_linear_fits);
a3 = linearfit([2.5,3,3.5,4,4.5,5],[0.8,1.1,1.8,2.2,2.8,3.2],plot_linear_fits);
a4 = linearfit([3,3.5,4,4.5,5],[0.9,1.1,1.8,2.2,2.9],plot_linear_fits);

% complete the tidal volume matix.
b1 = [1, a1.p1*setvt(2) + a1.p2 ,2, a1.p1*setvt(4) + a1.p2 ,3.1, a1.p1*setvt(6) + a1.p2 ,4.1];
b2 =  [0.8,1.2,1.7,2.1,2.8,3.2,3.8];
b3 = [a3.p1*setvt(1) + a3.p2 , 0.8,1.1,1.8,2.2,2.8,3.2];
b4 = [a4.p1*setvt(1) + a4.p2 , a4.p1*setvt(2) + a4.p2 ,0.9,1.1,1.8,2.2,2.9];

% create the calculated tidal volume matrix
vt = [b1;b2;b3;b4];
% set negative numbers to zero.
vt(vt<0) =0;

% generate 2D grid.
[DP,SETVT] = meshgrid(dp',setvt');
surf(DP',SETVT',vt);

% interpolated set tidal volume and driving pressure
setvti = 2:0.1:5;
dpi = 5:0.5:30;

[DPi,SETVTi] = meshgrid(dpi',setvti');

calculated_vt = interpn(DP',SETVT',vt,DPi',SETVTi');


surf(DPi',SETVTi',calculated_vt); colormap jet; colorbar;
xlabel('Driving Pressure (cmH_2O)');
ylabel('Set Tidal Volume (ml)');
zlabel('Delivered Tidal Volume (ml)');

% ressolution
ddpi = dpi(2)-dpi(1);
dsetvti = setvti(2)-setvti(2);

% 
% set_vt = 4;
% set_dp = 15;

x = find( abs(set_dp-dpi) <= dsetvti );
y = find( abs(set_vt-setvti) <= dsetvti );

z = calculated_vt(x,y);

