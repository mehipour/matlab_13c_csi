%% Created - on 10/22/2018 based on process_c13_csi_20180713

close all;
xenon = 0;

%% Basic input/output parameters 
show_proton = 1;             % show the proton image. 
show_maps = 0;               % show peak integrals
show_fused_map = 0;          % show metabolite maps overlaid on the proton image
% Ni_maps = 4;                 % interpolation factor for maps.
select_and_show_voxels = 0;  % allows selection and viewing of individual voxels on the fly.
save_fig = 0;                % if 1 then saves images.
save_data_structure = 0;     % if 1 then saves a structure of the results.
save_structure_for_r = 0;    % if 1 then resizes all images to a vector before saving as a structure
Ns = 1;                      % Number of 13C slices

%% Dicom Generation Parameters
generate_dicom = 0;         % generated and stores dicom maps.
normalize_dicom_images = 1; % if set to 1, then each maps will be normalized to its own maximum intensity.

%% Basic Masking and Segmentation parameters
manual_mask = 0;        % if selected, masking can be done manuual
use_previous_mask = 0;  % if a masked is made and wants to be preserved for the enxt dataset.

%% Automatic Segmentation parameters
mask_ratio_images = 0; % mask the ratio maps (lactate-to-pyruvate ratio, etc.)
mask_met_images = 1;   % mask the metabolite images
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
show_dynamics = 1;           % if 1 then show dynamics

% spectral quantification
global_quantification = 1;   % if 1 then do global quantification
side_quantification = 0;     % if 1 then each side is quantified separately.
regional_quantification = 0; % if 1 then regional lung quantification is performed over five regions (LP,RP,LA,RA,HR)
mrsi_voxel_selection = 1;    % if 0 then carbon maps will be used.  (requires show_maps to be 1)
show_lung_spectra = 1;       % 0 if don't want to see the spectra in lungs. Only applicalble for quantification.

% summarize all analysis in a new csv file
combine_all_in_csv_flag = 0; 

%% MRSI Visualization Parameters
zoom_y = 7;          % spectra y-scale
show_real_mrsi = 1;
show_norm_mrsi = 0;
color_peaks = 0;     % make the integrated area of each peak colored.
spectral_zoom = 1;   % generally set to 1 to zoom in on the pyr region.

%% C13/1H fused maps visualization parameteres
carbon_colormap = 'jet';              % colormap
opacity_factor = 0.55;                 % higher means less transparent
proton_threshold = 0.01;              % minimum relative intensity to NaN
carbon_threshold = 0.5;               % minimum relative intensity to NaN
opacity_method = 'intensity_based';   % can be either uniform or intensity_based
opacity_function = 'linear';          % can be linear or log
opacity_range = 0.8;
opacity_slider = 0;
noise_std_threshold = 1; 
average_signal = 1;                   % if 1 then shows the mean of all maps and signals. 

%% Processing Parameters
% debluring = 0.00002;  % the degree of debluring (0 is none) (0.00002 is good for 16x16 csi and FA= 8.6)
% debluring = 0.00005;  % the degree of debluring (0 is none) (0.00005 is complete correction for 16x16 csi and FA 8.6)
debluring = 0.00000;  % the degree of debluring (0 is none) (0.00005 is good for 16x16 csi and FA= 8.6)
lb = 0;              % line broadening in Hz 
fastfit = 0;          % faster fit, does not show indiviual spectra
flow = 0;             % if flow supression was used, affects 1st order phase

% Data list
data_list_dynamic_20181022();

%% File Loop

for ll = 2
    
    close all
    data_path = path(ll).name;
    fprintf('\ndataset: %s\n',data_path);

    % if proton image is wanted for carbon scans.
    if show_proton
        proton_lung_injury_20180208()
    else
        proton = zeros(128,128);
    end
   
    %% Process the magnitude spectra.
    [mrsi_abs,mrsi_complex,RE,IM] = csi_dynamic_reconabs_20181022(data_path,lb,debluring,Ns);
    fnorm8 = mrsi_abs;   
    if save_fig
        save_figure('raw_signal',[data_path '.fid/'],1,1,0);
    end
    % spectroscopic image matrix size
    [Nx,Ny,Nt,Ni,Ns] = size(mrsi_abs);

    %% Determine the range of metabolites and peaks.
    find_c13_chemical_shifts_20170308();
 
    %% matrix view of the CSI.
    gridshifts_dynamic_c13_20181022(); % load shifts. 
    spectrascale = zoom_y;
    
    % Check the FOVs, if they don't match the code generates another 13C
    % MRSI overlay on the cropped proton image for voxel selection and
    % quantifcation. The "fov_match" flag is generated here.
    find_FOVs_and_crop_proton_image();
        
    % overlay norm of the specta on the proton image
    if show_norm_mrsi
        img_abs = mrsi_abs;
        for image_num = 1:Ni        
            figure(1000); subplot(3,4,image_num); 
            img_abs(:,:,:,image_num) = show_csi_matrix_20170703(real(mrsi_abs(:,:,:,image_num)),...
                spectrascale,color_peaks,proton,show_proton,...
               xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,fov_match,spectral_zoom,xx,yy);
            title('magnitude mrsi')
            if ~fov_match   % fovs don't match so make another figure with matching fovs for peak selection.
              figure(1002); subplot(3,4,image_num); 
              img_abs(:,:,:,image_num) = show_csi_matrix_20170703(real(mrsi_abs(:,:,:,image_num)),...
                  spectrascale,color_peaks,proton_cropped,show_proton,...
               xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy);
            end
            if save_fig
                figure(1000);
                save_figure('mrsi_abs',[data_path '.fid/'],1,1,0)
            end
        end
         if average_signal
            abs_mean_mrsi = mean(mrsi_abs,4);
            figure(1003);
            img_mean = show_csi_matrix_20170703(abs_mean_mrsi,spectrascale,color_peaks,proton_cropped,show_proton,...
               xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy);   
         end   
    end

    % overlay phased real portion of the specta on the proton image
    if show_real_mrsi   
        real_mrsi = mrsi_abs;
        for image_num = 1:Ni
            image_num
            temp = strfind(data_path,'/');
            if ~debluring % if no debluring
                mrsi_path = [data_path(1:temp(end-1)) 'deblur0' data_path(temp(end):end) num2str(image_num) '.mat'];
            else
                mrsi_path = [data_path(1:temp(end-1)) 'deblur1' data_path(temp(end):end) num2str(image_num) '.mat'];
            end
            % check if mrsi fit exists, if not run it.
            if ~exist(mrsi_path)
                mrsi = squeeze(mrsi_complex(:,:,:,image_num));
                real_mrsi(:,:,:,image_num) = csi_dynamic_reconphased_20181022_carbon(mrsi,data_path,lb,debluring,fastfit,flow,lac_bigger_than_pyr,image_num,RE,IM);   
                load(mrsi_path);
            else
                load(mrsi_path);
                real_mrsi(:,:,:,image_num) = squeeze(img);
            end

            figure(1001);
            subplot(3,4,image_num)
            img_abs(:,:,:,image_num) = show_csi_matrix_20170703(squeeze(real_mrsi(:,:,:,image_num)),spectrascale,color_peaks,proton,show_proton,...
               xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,fov_match,spectral_zoom,xx,yy);
            title('real mrsi');
            if save_fig
                save_figure('mrsi_real',[data_path '.fid/'],1,1,0)
            end
            if ~fov_match   % fovs don't match so make another figure with matching fovs for peak selection.
              figure(1002);
              subplot(3,4,image_num)
              img_abs(:,:,:,image_num) = show_csi_matrix_20170703(squeeze(real_mrsi(:,:,:,image_num)),spectrascale,color_peaks,proton_cropped,show_proton,...
               xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy);
            end
        end
        
        if average_signal
            real_mean_mrsi = mean(real_mrsi,4);
            figure(1003);
            img_mean = show_csi_matrix_20170703(real_mean_mrsi,spectrascale,color_peaks,proton_cropped,show_proton,...
               xgridshift,ygridshift,pyr_idx,lac_idx,ala_idx,1,spectral_zoom,xx,yy);   
        end
    end

    %% create maps from img_map
    pyr_img = zeros(Nx,Ny,Ni);
    lac_img = zeros(Nx,Ny,Ni);
    ala_img = zeros(Nx,Ny,Ni);
    bic_img = zeros(Nx,Ny,Ni);
    for image_num = 1:Ni
        img = squeeze(img_abs(:,:,:,image_num));
        if show_maps
            show_peak_dynamic_maps_20181024();
        end
        if show_fused_map
            figure(1543);
            show_fused_carbon_and_proton_maps_20180208();
        end
    end

    %% quantifying metabolites.
    if quantify_metabolites
                
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
    
    %% Show timec course
    if show_dynamics
        pyr_time_course = zeros(Nx,Ny,Ni);
        lac_time_course = zeros(Nx,Ny,Ni);
        timecourse_spectra = zeros(size(real_mrsi,3),Ni);
        kinetic_mask = zeros(8,8,128);
        
        % create 3D mask
        for xdir = 1:Nx
            for ydir = 1:Ny
                if mask_lungs(xdir,ydir)
                    kinetic_mask(xdir,ydir,:) = 1;
                end
            end
        end
        
%         img_abs = img_abs +1;
        for image_num = 1:Ni
            % plot sum of spectra over the lungs (acount for the ones that are zero)
            scaled_img = real(squeeze(img_abs(:,:,:,image_num))) * max(max(max(real_mrsi(:,:,:,image_num))))+1;
            timecourse_spectra(:,image_num) = squeeze(sum(sum((scaled_img).* rot90(kinetic_mask,2)),2))/Nl;
        end
        pyr_timecourse = sum(timecourse_spectra(pyr_idx,:),1);
        lac_timecourse = sum(timecourse_spectra(lac_idx,:),1);
        figure(654);
        plot(pyr_timecourse); hold on; plot(lac_timecourse); hold off; 
        
        figure(655);
        for ii = 1:11
            plot(squeeze(timecourse_spectra(:,ii))-1*(ii-1)); hold on;
        end      
        hold off;
    end
    
    
end
fprintf('\n End of analysis \n'); 

