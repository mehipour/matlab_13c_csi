%% Created - on 10/27/2015
%
% file updated on 10/28/2015 by MP
%
% filed updated on 11/13/2015 by MP to have colored represenation for he
% individual peaks. 
%
% Update(1) on 2/17/2016 by MP to clean it up for the HCL injury paper. 
%
% Update(2) on 6/26/2016 added updated functions and plotting of the norm of the spectra 
%
% Update(3) on 9/12/2016 by MP to call steve's for the real overlay
%
% Update(4) on 10/20/2016 added the regional quantification function
%
% Update(5) on 10/21/2016 Uses different parameters for mice.
%
% Update(6) on 11/03/2016 Uses a different quantification for kidneys, also
% updated the show_carbon_map_date function.
%
% Update(7) on 11/07/2016 to be able to quantify the spectra regionally
% using the magnitude of the spectra as well.
%
% Update(8) on 12/02/2016 changed the first order phase in sequence's code
% for data with flow supression on. Flag must be set to 1 though. Also uses
% the newer quantification files which use a new voxel selection function.
%
% Update(9) on 12/12/2016 introduced the new variable use_fits_to_quantify.
% if set 1, then it uses the fit spectra from Steve's code, otherwise it
% would take the area under the peak of the phased real spectra.
%
% Update(10) on 1/24/2017 add the option to process the xenon spectorscopic
% data.
%
% Update(11) on 2/21/2017 calls a new map function to mask the ratio
% images. The new flag is mask_ratio and the threshold parameter is the
% fraction of the pyruvate or gas phase image relative to their maximum
% value that is ignored.
%
% Update(12) on 2/23/2017 has a better way to save files with different
% file names, also added a new code piece "find_FOVs_and_crop_proton_image"
% to check the FOVs of the proton and carbon images and generate the proper
% overlays. now the code can overlay carbon images with any FOV on any
% proton image with any FOV and matrix size. We no longer have the
% fov_match input variable, this also eliminates the need to have a
% "species" variable for mice and rats. The 
%
% Update(13) on 3/3/2017 incorporated the csi2dcom function here, also
% allows for various masking options including proton masking, carbon
% masking 'nand' or 'or' combination masking
%
% Update(14) on 3/6/2017 maps can be generated from either the fits or the
% integrals depending on the "use_fits_to_quantify" flag
%
% Update(15) on 3/8/2017, by MP, added the lac_bigger_than_pyr flag for 
% chemical shift calculation. 
%
% Update(16) on 3/12/2017, by MP, introduced a new flag for quantification
% named side_quantification. It should be used to compare one organ to its
% contralateral (i.e. lungs, kidneys, etc.). The function
% quantify_kidney_... is taken out now
%
% Update(17) on 3/19/2017, by MP, uses a refined processing code for the
% magnitude of the spectra, adds line broadening and debluring. Also does
% not save the magnitude of the MRSI data as the processing is very quick.
%
% Update(18) on 4/26/2017, by MP, PRM capabiliy is added, needs to have 3
% or 4 injections included
%
% Update(18) on 6/21/2017, by MP, Now uses the new quantification functions
% where it saves individual metabolites in csv files. Also can do global,
% side and regional quantification separately rather than choosing one
% only.
%
% Update(19) on 7/02/2017, by MP, Manual mask selection is optional to
% create dicom maps. Also gives the option "not normalize" metabolite maps
% to their maximum intensity.
%
% Update(20) on 7/03/2017, by MP, uses a different show_csi_matrix function
% (dated 20170703), so that the images and dicom maps can be produced from
% a non-normalized "img"
%
% Update(21) on 2/01/2018, by MP, calls the updated quantification
% functions with more refined output in matlab command window.
%
% Update(22) on 2/07/2018, by MP, can now do the following:
% a. shows the fused maps.
% b. can segment on the fused maps for quantificaiton
% c. can create one csv file for multiple datasets if processed in batch
% d. reads data from the new combined data_list_file
%
% Update(23) on 8/13/2018, by MP, can now do the following:
% a. uses new regional and global quantification files to save the csv
% files for all animals in one file if "combine_all_in_csv_flag" is 1
% b. the data list file also includes the spo2 now. 

close all;
%% nucleus; if xenon is 0, then it is carbon.
xenon = 0;

%% Basic input/output parameters 
show_proton = 1;             % show the proton image. 
show_maps = 1;               % show peak integrals
show_fused_map = 1;          % show metabolite maps overlaid on the proton image
Ni_maps = 6;                 % interpolation factor for maps.
select_and_show_voxels = 0;  % allows selection and viewing of individual voxels on the fly.
save_fig = 1;                % if 1 then saves images.
save_data_structure = 0;     % if 1 then saves a structure of the results.
save_structure_for_r = 0;    % if 1 then resizes all images to a vector before saving as a structure

%% Dicom Generation Parameters
generate_dicom = 1;         % generated and stores dicom maps.
normalize_dicom_images = 1; % if set to 1, then each maps will be normalized to its own maximum intensity.

%% Basic Masking and Segmentation parameters
manual_mask = 0;        % if selected, masking can be done manually
use_previous_mask = 0;  % if a masked is made and wants to be preserved for the enxt dataset.

%% Automatic Segmentation parameters
mask_ratio_images = 0; % mask the ratio maps (lactate-to-pyruvate ratio, etc.)
mask_met_images = 0;   % mask the metabolite images
make_lac2pyr = 1;      % save the lactate-to-pyruvate map as dicom
proton_mask = 0;       % use the proton image to create a mask.
carbon_mask = 0;       % use the carbon image to create a mask.
nand_mask_combination = 1;    % use the xor of carbon and proton masks, useful for lung thresholding.
closing_disk_size = 8;        % used when nand masking is used for morphological closing.
proton_mask_threshold = 0.15; % ignore values smaller than this fraction of the maximum value of proton image
carbon_mask_threshold = 0.2;  % ignore values smaller than this fraction of the maximum value of carbon image

%% Quantification Parameters
% general parameters
quantify_metabolites = 1;    % metabolite quantifcation, 
lac_bigger_than_pyr = 0;     % set this to 1 if lactate is bigger than pyruvate
proton_sum_image = 0;        % if 1 then sums over (-3,+3) or (-2,2) slice positions.
use_fits_to_quantify = 0;    % if 1 then uses the fits for quantification and generating maps (only works for quantification if "average_then_integrate" flag is 0.
average_then_integrate = 1;  % if 1 then then metabolites will be quantified from the integral of the average of the spectra in a region.

% spectral quantification
global_quantification = 1;   % if 1 then do global quantification
side_quantification = 1;     % if 1 then each side is quantified separately.
regional_quantification =0; % if 1 then regional lung quantification is performed over five regions (LP,RP,LA,RA,HR)
mrsi_voxel_selection = 1;    % if 0 then carbon maps will be used.  (requires show_maps to be 1)
show_lung_spectra = 0;       % 0 if don't want to see the spectra in lungs. Only applicalble for quantification.

% imaging quantification
mask_quantification = 0;     % if 1 then use segmented masks for quantificationRu

% summarize all analysis in a new csv file
combine_all_in_csv_flag = 0; 

%% PRM Parameters
do_prm = 0;
prm_counter = 0;
process_ended = 0;

%% MRSI Visualization Parameters
zoom_y = 7;          % spectra y-scale
show_real_mrsi = 1;
show_norm_mrsi = 0;
color_peaks = 0;     % make the integrated area of each peak colored.
spectral_zoom = 1;   % generally set to 1 to zoom in on the pyr region.
xcircshift = 0;      % circularly shifts MRSI grid along x for wrap-around
ycircshift = 0;      % circularly shifts MRSI grid along y for wrap-around

%% C13/1H fused maps visualization parameteres
carbon_colormap = 'hot';              % colormap
opacity_factor = 0.55;                 % higher means less transparent
proton_threshold = 0.01;              % minimum relative intensity to NaN
carbon_threshold = 0.5;               % minimum relative intensity to NaN
opacity_method = 'intensity_based';   % can be either uniform or intensity_based
opacity_function = 'linear';          % can be linear or log
opacity_range = 0.8;
opacity_slider = 0;
noise_std_threshold = 1; 

%% Processing Parameters
% debluring = 0.00002;  % the degree of debluring (0 is none) (0.00002 is good for 16x16 csi and FA= 8.6)
% debluring = 0.00005;  % the degree of debluring (0 is none) (0.00005 is complete correction for 16x16 csi and FA 8.6)
debluring = 0.00000;  % the degree of debluring (0 is none) (0.00005 is good for 16x16 csi and FA= 8.6)
lb = 30;              % line broadening in Hz 
fastfit = 0;          % faster fit, does not show indiviual spectra
flow = 0;             % if flow supression was used, affects 1st order phase

% manage X nucle dataset
if xenon 
    xe129_data_list_20170124(); 
    quantify_metabolites = 0;
    spectral_zoom = 0;
    generate_dicom = 0;
    show_proton = 0;
    proton = zeros(128,128); % no proton image for xenon experiments
else
    data_list_20180208();
end

%% File Loop959
% for ll = [54:56 , 63:74 , 122:130 , 138:140 , 144:146 , 152:154  , 157:159 , 166:168 , 176:182 , 185:192 , 196:206 , 208:211 , 220:247 , 250:343]
% for ll = [308:343]
% for ll = 300

%% added by mp
ppp = 0;
inja = zeros(128,4);
csa = zeros(128,4);
for ll = 4001
    
%     close all
    data_path = path(ll).name;
    fprintf('\ndataset: %s\n',data_path);

    % if proton image is wanted for carbon scans.
    if show_proton
        proton_lung_injury_20180208()
    end
        
    % manage quantificaiton, if regional quantificaiotn is requested
    % proton sum image will be used for overlay.
    if quantify_metabolites
        if regional_quantification
            proton_sum_image = 1;
        end
        if strfind(data_path,'kidney')
            regional_quantification = 0;
            side_quantification = 1;
        end
    end
    
    %% Process the magnitude spectra.
    [fnorm8,kspace,RE,IM] = csireconabs_20170319(data_path,lb,debluring);
            
    if save_fig
        save_figure('raw_signal',[data_path '.fid/'],1,1,0);
    end
    % spectroscopic image matrix size
    [Nx,Ny,Nt] = size(fnorm8);

    %% Determine the range of metabolites and peaks.
    if xenon
        find_xe129_chemical_shifts_20170124();
    else
        find_c13_chemical_shifts_20170308();
    end
   
    %% matrix view of the CSI.
    if xenon
        gridshifts_xe129_20170124(); % load shifts. 
    else
        gridshifts_c13_20170124(); % load shifts. 
    end
    spectrascale = zoom_y;
    
    % Check the FOVs, if they don't match the code generates another 13C
    % MRSI overlay on the cropped proton image for voxel selection and
    % quantifcation. The "fov_match" flag is generated here.
    find_FOVs_and_crop_proton_image();
    
    % overlay norm of the specta on the proton image
    if show_norm_mrsi
        figure(1000);    
        img_abs = show_csi_matrix_20190409(real(fnorm8),spectrascale,color_peaks,proton,show_proton,...
           xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,fov_match,spectral_zoom,xx,yy,1,1,xcircshift,ycircshift);
        title('magnitude mrsi')
        if ~fov_match   % fovs don't match so make another figure with matching fovs for peak selection.
          figure(1002);
          img_abs = show_csi_matrix_20190409(real(fnorm8),spectrascale,color_peaks,proton_cropped,show_proton,...
           xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy,1,1,xcircshift,ycircshift);
        end
        if save_fig
            figure(1000);
            save_figure('mrsi_abs',[data_path '.fid/'],1,1,0)
        end
    end

    % overlay phased real portion of the specta on the proton image
    if show_real_mrsi       
        temp = strfind(data_path,'/');
        if ~debluring % if no debluring
            mrsi_path = [data_path(1:temp(end-1)) 'deblur0' data_path(temp(end):end) '.mat'];
        else
            mrsi_path = [data_path(1:temp(end-1)) 'deblur1' data_path(temp(end):end) '.mat'];
        end
        % check if mrsi fit exists, if not run it.
        if ~exist(mrsi_path)
            if xenon
                real_mrsi = csireconphased_20170124_xenon(data_path,debluring,fastfit,flow);
            else
                real_mrsi = csireconphased_20170319_carbon(data_path,lb,debluring,fastfit,flow,lac_bigger_than_pyr);   
            end
            load(mrsi_path);
        else
            load(mrsi_path);
            real_mrsi = img;
        end
        
        figure(1001);
        img = show_csi_matrix_20190409(real_mrsi,spectrascale,color_peaks,proton,show_proton,...
           xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,fov_match,spectral_zoom,xx,yy,1,1,xcircshift,ycircshift);
        title('real mrsi');
        if save_fig
            save_figure('mrsi_real',[data_path '.fid/'],1,1,0)
        end
        if ~fov_match   % fovs don't match so make another figure with matching fovs for peak selection.
          figure(1002);
          img = show_csi_matrix_20190409(real_mrsi,spectrascale,color_peaks,proton_cropped,show_proton,...
           xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy,1,1,xcircshift,ycircshift);
        end
    end

    %% create maps from img_map
    if show_maps
        show_peak_maps_20180309();
    end
    if show_fused_map
        figure(1543);
        show_fused_carbon_and_proton_maps_20180208();
    end

    %% quantifying metabolites.
    if quantify_metabolites
        
        % mask quantification with segmented regions
        if mask_quantification
            fprintf('\n*********** Quantifying Metabolites by segmentation, plase select the regions\n');
            quantify_masked_lung_regions_20180208();     
        end
        
        fprintf('\n*********** Quantifying Metabolites, user must select voxels if did not before\n');

        % spectral quantificaiton
        % if no real spectra was processed
        if ~show_real_mrsi
            fprintf('\nQuantify with the magnitude of spectra\n\n');
            img = img_abs;
            if ~fov_match   % go back to the zoomed image.
                figure(1002);
            else
                figure(1000);
            end
        else       
            fprintf('\nQuantify with the real part of spectra\n\n');
            % if using the real data
            if ~fov_match   % go back to the zoomed image.
                figure(1002);
            else
                figure(1001);
            end
        end
        if side_quantification
            if ~fov_match   % go back to the zoomed image.
                figure(1002);
            else
                figure(1000);
            end
            quantify_sides_spectra_20180309();
        end
        if regional_quantification
            if ~fov_match   % go back to the zoomed image.
                figure(1002);
            else
                figure(1000);
            end
            quantify_regional_spectra_20180713();
        end
        if global_quantification
            if ~fov_match   % go back to the zoomed image.
                figure(1002);
            else
                figure(1000);
            end
            quantify_global_spectra_20180713();
        end
        
    end
    
    %% Generated DICOM Maps
    if generate_dicom
        csi2dicom_rat_20170703();
    end

    %% Viewing Individual voxels
    if select_and_show_voxels
        figure(981); subplot(1,2,1);
        title('Click on the voxel to view it')
        if ~fov_match
            if show_real_mrsi
                mrsi_data = show_csi_matrix_20190409(real_mrsi,spectrascale,color_peaks,proton_cropped,show_proton,...
                xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy,1,1,xcircshift,xycircshift);  
            else
                mrsi_data = show_csi_matrix_20190409(real(fnorm8),spectrascale,color_peaks,proton_cropped,show_proton,...
                xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy,1,1,xcircshift,xycircshift);
            end
            [Xl,Yl]=getspectra_click_20190409(mrsi_data,proton_cropped,xgridshift,ygridshift,select_and_show_voxels,cs);
        else
            if show_real_mrsi
                mrsi_data = show_csi_matrix_20190409(real_mrsi,spectrascale,color_peaks,proton_cropped,show_proton,...
                xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy,1,1,xcircshift,xycircshift);  
            else
                mrsi_data = show_csi_matrix_20190409(real(fnorm8),spectrascale,color_peaks,proton_cropped,show_proton,...
                xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy,1,1,xcircshift,xycircshift);
            end
            [Xl,Yl]=getspectra_click_20170313(mrsi_data,proton,xgridshift,ygridshift,select_and_show_voxels,cs);
        end
    end
    
    %% Generate Parametric Maps
    if do_prm
        prm_counter = prm_counter+1;
        % use the mask of the second injection for the next injections.
        if prm_counter == 2
            use_previous_mask = 1; 
        end
        plot_prm_20180314();
    end
    
    % save all data in structures
    if and(quantify_metabolites,save_data_structure)
        save_csi_data_as_structure_20180315
    end
    
    %% added by mp
    ppp =  ppp + 1;
    inja(:,ppp) = sum_spec_lungs; 
    csa(:,ppp) = cs';
    
end
% draw the final plot together
if do_prm
    process_ended = 1;
    plot_prm_20180314();
end


fprintf('\n End of analysis \n'); 

figure; plot(inja); legend('inj1','inj2','inj3','inj4')
