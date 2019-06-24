% compare_mrsi_data_20170224
%% Created on 12/02/2016 by MP
% select two MRSI datasets for comparison.
%
%% Updated on 02/24/2017 by MP
% takes the size of images into account and loads the data from any folder.
% species and fov_match inpur variables are gone now.

% load list of the carbon datasets.
data_list_20180208();
close all

% Requirement:
% 1. data must have been processed by the process_c13_date file.
% 2. set show_real_mrsi to 1 only if real data is available.
% note that if 2 is true, lactate, pyruvate and their ratio will be shown
% in the command window for each voxel.
%
% Instructions:
% 1. Select the number associated with the desired datasets.
% 2. Once the MRSI overlays are loaded, select the voxel to compare between
% scans on the TOP image. The voxel will be highlighted on both MRSI
% overlays.
% 3. Once done, select a regions outside the top image.

%% select datasets to compare:
ll1 = 3001;
ll2 = 3002;

%% Configure MRSI Visualization
spectrascale = 7; % spectra y-scale
show_real_mrsi = 1;
spectral_zoom = 1; % generally set to 1 to zoom in on the pyr region.
proton_sum_image = 0;
spectral_ppm_range = [150 190];
spectral_interpolation_factor = 4;

%% Initialize
data_path1 = path(ll1).name;
data_path2 = path(ll2).name;
fprintf('\ndataset 1 : %s\n',data_path1);
fprintf('\ndataset 2 : %s\n',data_path2);

%% Determine Spatial Shifts
ll = ll1; gridshifts_c13_20170124 
x1gridshift = xgridshift; y1gridshift = ygridshift;
ll = ll2; gridshifts_c13_20170124 
x2gridshift = xgridshift; y2gridshift = ygridshift; 

%% Load Proton Scans.
ll = ll1; proton_lung_injury_20180208(); 
find_FOVs_and_crop_proton_image;
proton1 = proton;
proton_cropped1 = proton_cropped;
ll = ll2; proton_lung_injury_20180208(); 
find_FOVs_and_crop_proton_image; 
proton2 = proton;
proton_cropped2 = proton_cropped;

%% Load Carbon  datasets:
% load norm spectra
load([data_path1 '.fid/mrsi.mat']); mrsi1 = fnorm8;
load([data_path2 '.fid/mrsi.mat']); mrsi2 = fnorm8;
% load chemical shifts
[~,~,Nt] = size(fnorm8);
data_path = data_path1; find_c13_chemical_shifts_20170308(); cs1 = cs;
data_path = data_path2; find_c13_chemical_shifts_20170308(); cs2 = cs;

if show_real_mrsi
    temp = strfind(data_path,'/');
    mrsi_path1 = [data_path1(1:temp(end-1)) 'deblur0' data_path1(temp(end):end) '.mat'];
    load(mrsi_path1);
    mrsi1 = img;
    pyr1 = scaledimages(:,:,1);
    lac1 = scaledimages(:,:,5); 
    
    % show real spectra of dataset 2
    temp = strfind(data_path,'/');
    mrsi_path2 = [data_path2(1:temp(end-1)) 'deblur0' data_path2(temp(end):end) '.mat'];
    load(mrsi_path2);
    mrsi2 = img;
    pyr2 = scaledimages(:,:,1);
    lac2 = scaledimages(:,:,5); 
end
              
figure(1000);
subplot(2,2,1);
img1 = show_csi_matrix_20170703(mrsi1/max(mrsi1(:)),spectrascale,0,proton_cropped1,1,...
xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy);
title('pick a voxel from the top image');

subplot(2,2,3);
img2 = show_csi_matrix_20170703(mrsi2/max(mrsi2(:)),spectrascale,0,proton_cropped2,1,...
xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy);
   

%%
[Nxh Nyh] = size(proton_cropped1); % size of the proton image;
[Nxc Nyc Nfc] = size(img1); % size of the spectroscopic carbon image
% ratio between proton and carbon image sizes
xratio = Nxh/Nxc;
yratio = Nyh/Nyc; 

fprintf('Select the desired spetra...\n')
fprintf('click on the next spectrum or say "done" if finished\n')

x1 = x1gridshift+1;
y1 = y1gridshift+1;
x2 = x2gridshift+1;
y2 = y2gridshift+1;
I = ones(10,1); % vector to draw lines around the selected spectra
hold on;
ii = 0;
% run until forced the exit
while (and(and((x1-x1gridshift)>0,(y1-y1gridshift)>0),and((x1-x1gridshift)<Nxh,(y1-y1gridshift)<Nyh)))
    % input from the mouse
    subplot(2,2,1);
    hold on;
    [x y] = ginput(1);
    % take the grid shift into account. 
    x = x-x1gridshift;
    y = y-y1gridshift;
    x = x-x2gridshift;
    y = y-y2gridshift;
    Y = ceil(y/yratio);
    X = (Nxc+1)-ceil(x/xratio);
    xl1 = linspace(floor(x/xratio)*xratio+1,ceil(x/xratio)*xratio+1,length(I))+x1gridshift;
    yl1 = linspace(floor(y/yratio)*yratio+1,ceil(y/yratio)*yratio+1,length(I))+y1gridshift;
    xl2 = linspace(floor(x/xratio)*xratio+1,ceil(x/xratio)*xratio+1,length(I))+x2gridshift;
    yl2 = linspace(floor(y/yratio)*yratio+1,ceil(y/yratio)*yratio+1,length(I))+y2gridshift;
    
     % check if a green box is draw before, if so delete it.
    if exist('h11','var')
        delete(h11);
        delete(h22);
        delete(h33)
        delete(h44);
    end 
    % plot the new green box.
    h11 = plot(xl1(1)*I,yl1,'g');
    h22 = plot(xl1(end)*I,yl1,'g');
    h33 = plot(xl1,yl1(1)*I,'g');
    h44 = plot(xl1,yl1(end)*I,'g');
    
    subplot(2,2,3);
    hold on;
    % check if a green box is draw before, if so delete it.
    if exist('h55','var')
        delete(h55);
        delete(h66);
        delete(h77)
        delete(h88);
    end 
    % plot the new green box.
    h55 = plot(xl2(1)*I,yl2,'g');
    h66 = plot(xl2(end)*I,yl2,'g');
    h77 = plot(xl2,yl2(1)*I,'g');
    h88 = plot(xl2,yl2(end)*I,'g');
       
    % pick the selected voxel for visualization.
    selected_voxel_spectrum1 = squeeze(img1(Y,X,:));
    selected_voxel_spectrum2 = squeeze(img2(Y,X,:));
    
    % interpolate spectra if required.
    Nif = spectral_interpolation_factor;
    if Nif > 1
        selected_voxel_spectrum1i = interp1(linspace(1,Nt,Nt),selected_voxel_spectrum1,linspace(1,Nt,Nif*Nt));
        selected_voxel_spectrum2i = interp1(linspace(1,Nt,Nt),selected_voxel_spectrum2,linspace(1,Nt,Nif*Nt));
        cs1i = interp1(linspace(1,Nt,Nt),cs1,linspace(1,Nt,Nif*Nt));
        cs2i = interp1(linspace(1,Nt,Nt),cs2,linspace(1,Nt,Nif*Nt));
    else 
        selected_voxel_spectrum1i = selected_voxel_spectrum1;
        selected_voxel_spectrum2i = selected_voxel_spectrum2;
        cs1i = cs1;
        cs2i = cs2;
    end
    
    ymax = max(max([selected_voxel_spectrum1i;selected_voxel_spectrum2i]));
    ymin = min(min([selected_voxel_spectrum1i;selected_voxel_spectrum2i]));

    subplot(2,2,2);
    hold off;
    plot(cs1i,selected_voxel_spectrum1i);
    xlabel('Chemical Shift (ppm)');
    ylabel('Signal Intensity (a.u.)');
    title('voxel of image 1');
    ylim([ymin-0.05*ymax ymax*1.1]);
    xlim([spectral_ppm_range(1) spectral_ppm_range(end)]);
    set(gca, 'xdir','reverse');
    % pick the selected voxel for visualization.
    subplot(2,2,4);
    hold off;
    plot(cs2i,selected_voxel_spectrum2i);
    xlabel('Chemical Shift (ppm)');
    ylabel('Signal Intensity (a.u.)');
    title('voxel of image 1');
    ylim([ymin-0.05*ymax ymax*1.1]);
    xlim([spectral_ppm_range(1) spectral_ppm_range(end)]);
    set(gca, 'xdir','reverse');
    
    %% quantification
    lac2pyr1 = lac1./pyr1;
    lac2pyr2 = lac2./pyr2;
    ['lac2pyr     ' 'lactate     ' 'pyruvate        ']
    [lac2pyr1(Y,X) lac1(Y,X) pyr1(Y,X)]
    [lac2pyr2(Y,X) lac2(Y,X) pyr2(Y,X)]   
end


