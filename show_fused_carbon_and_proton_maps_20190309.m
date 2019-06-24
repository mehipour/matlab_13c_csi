% show_fused_carbon_and_proton_maps_20190309
%
% created by MP on 2/6/2018
%
% parameters needed:
% carbon_colormap = 'hot';              % colormap
% opacity_factor = 0.5;                 % higher means less transparent
% proton_threshold = 0.01;              % minimum relative intensity to NaN
% carbon_threshold = 0.4;               % minimum relative intensity to NaN
% opacity_method = 'intensity_based';   % can be either uniform or intensity_based
% opacity_function = 'linear';          % can be linear or log
% opacity_range = 0.6;
% opacity_slider = 0.1;
% noise_std_threshold =1;               % NaN if voxel < noise-std_treshold*std
%
%
% Update (1) by MP on 2/7/2018
% Can change the colormap and opacity method.
%
% Update (2) by MP on 2/8/2018
% instead of using the min of signal, it uses the average of four corners
% of the image for noise. 
%
% Update (3) by MP on 10/23/2018
% Includes the x and y grid shifts when corpping the proton image to
% properly overlay the metabolic map on the proton image.
%
% Update (4) by MP on 03/09/2019
% Circularly shifts the carbon image as necessary.


% gray levels
gray_levels = 255;

% normalize images
proton_cropped2 = double(proton_cropped);
norm_proton = (proton_cropped2-min(proton_cropped2(:)))/max(proton_cropped2(:))*gray_levels;

% define color maps for the proton and carbon images
colormap_function = str2func(carbon_colormap);
fused_colormap = [gray(gray_levels); colormap_function(gray_levels)];

% treshold proton image
norm_proton(norm_proton<max(norm_proton(:)*proton_threshold)) = NaN;

% create subplot layout
[n1,n2] = select_subplot_number(length(met_maps));

% loop over the metabolite maps
for map_loop = 1:length(met_maps)
    
    % signal from the 4 corners of the image to measure noise
    noise1 = met_maps(map_loop).map(1:10,1:10);
    noise2 = met_maps(map_loop).map(end-9:end,1:10);
    noise3 = met_maps(map_loop).map(1:10,end-9:end);
    noise4 = met_maps(map_loop).map(1:10,end-9:end);
    noise = [noise1(:);noise2(:);noise3(:);noise4(:)];
    map = met_maps(map_loop).map;
    % eliminate any sudden variation in image baseline baseline
    map(map < nanmean(noise) - noise_std_threshold*std(noise)) = NaN;
    
    % normalize carbon map
    norm_map_preshift = (map-min(map(:)))/ max(map(:)) * gray_levels + gray_levels + 1; 
    
    % circularly shift map 
    norm_map = circshift(norm_map_preshift,[-ygridshift xgridshift]);
    
    
    % select the opacity function and threshod
    if strcmp(opacity_method,'uniform')
        opacity_map = opacity_factor*ones(size(i1));
    elseif strcmp(opacity_method,'intensity_based')
        if strcmp(opacity_function,'linear')
            opacity_map = opacity_factor*(opacity_range*norm_map/gray_levels+opacity_slider);
        elseif strcmp(opacity_function,'log')
            opacity_map = opacity_factor*log(1+opacity_range*norm_map/gray_levels+opacity_slider);
        end
    end
    
    % threshold map
    norm_map(norm_map<max(norm_map(:)*carbon_threshold)) = NaN;

    % load the fused maps
    subplot(n1,n2,map_loop);
    i1 = image(norm_proton); 
    hold on;
    i2 = image(norm_map);
    colormap(fused_colormap);
    set(i2, 'alphadata', opacity_map);
    title(met_maps(map_loop).metabolite); hold off; axis square;  
end

if save_fig
    save_figure('fused_maps',[data_path '.fid/'],1,1,0)
end



