%% quanitfy_global_spectra_20180121
% file created by Mehrdad Pourfathi on 2/18/2016
%
% update(1) on 9/7/2016 by MP to include transplant data
%
% update(2) on 9/13/2016 by MP to use steve's fits for ratio measurements
% and saves individual ones. 
%
% update(3) on 9/14/2016 by MP now has the option to do the voxel selection
% based on an MRSI overlay or a carbon map.
%
% update(4) on 10/07/2016 by MP, dataset number is now added to the name of
% lung voxel files.
%
% update(5) on 11/27/2016 by MP, measures pyruvate and lactate SNR of the voxels.
%
% update(6) on 12/02/2016 by MP, uses the updated getspectra_click_20161202
% function
%
% update(7) on 12/12/2016 by MP, can quantify either based on the fits or
% the integral of the data.
%
% update(8) on 01/12/2017 by MP, updated file path
%
% update(9) on 02/23/2017 by MP, made it easier to deal with file paths
%
% update(10) on 03/02/2017 by MP, added alanine, lac2ala and ala2pyr to the
% output
%
% update(11) on 03/12/2017 by MP:
% -any size proton image can be clicked on now.
% -A csv file is also generated as output.
%
% update(12) on 06/21/2017 by MP:
% saves a CVS file with individual metabolites and their voxels positions,
% also saves alanine data.
%
% update(13) on 01/21/2018 by MP:
% saves the alanine and bicarbonate values to the CSV file too.
%
% update(14) on 02/01/2018 by MP:
% Output in the matlab window is now more refined.
%
% update(15) on 03/09/2018 by MP:
% it rescales the fitted imaging data to have the same maximum value as the
% images obtained from the area under the peak.
%
% update(16) on 07/13/2018 by MP:
% uses the combine_all_in_csv_flag flag to save data from all animals
% in one csv file for both the global data
%
% update(17) on 07/29/2018 by MP:
% introduced the average_then_quantify flag. This allows quantification of
% metabolites in each region from the average of the spectra in that region
% rather. 


% find signal from the first spectrum acquired and scale the signal
gain = readprocpar(data_path, 'gain');
max_signal = sqrt(max(RE(:)).^2 + max(IM(:)).^2) / 2^(gain(2)/6);

% csi image with the non-normalized values
img1 = img*max_signal;

% check if lung voxels exists.
temp = strfind(data_path,'/');
voxels_path = data_path(1:temp(end-1));  
voxels_file = strcat(voxels_path,'lung_voxels',data_path(end-1:end),'.mat');
% check if voxels in the lungs ahve already been selected
if ~exist(voxels_file)
    % select the voxels over the lungs
    if mrsi_voxel_selection
        if ~fov_match
%             [Xl,Yl,Xp,Yp]=getspectra_click(img,proton(17:112,17:112),xgridshift,ygridshift);
            [Xl,Yl]=getspectra_click_20190311(img,proton_cropped,xgridshift,ygridshift,0,0,0);
        else
            [Xl,Yl]=getspectra_click_20190311(img,proton,xgridshift,ygridshift);
        end
        % if voxels are selected from the mrsi data then flip them.
        Yl = Nx-Yl+1;
        Xl = Nx-Xl+1;       
    else
        imagesc(pyr_img); axis square; colormap hot;
        [Xl,Yl] = getcarbonvoxel(pyr_img);
    end
    save(voxels_file,'Xl','Yl');
    if save_fig
       save_figure(strcat('csi_masked_',data_path(end-1:end)),voxels_path,1,1,0);
    end
else
    load(strcat(voxels_path,strcat('lung_voxels',data_path(end-1:end),'.mat')));
end

%% Quantification
Nf = size(img,3); % number of points in each spectrum.

voxels_csv_file = strcat(voxels_path,'lung_voxels',data_path(end-1:end),'.csv');

fid = fopen(voxels_csv_file,'w');
fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
    'No. of Voxels','Mean Lac','Std Lac','Mean Pyr','Std Pyr',...
    'Mean Ala', 'Std Ala', 'Mean Bic', 'Std Bic');
fclose(fid);

% quantify spectra in the lungs.
Nl = length(Xl); % number of spectra in the lungs.
[Nxl,Nyl]=select_subplot_number(length(Xl)); % select proper layout

% plot individual spectra with indicies and create a mask over the lungs.
mask_lungs = zeros(Nx,Ny,Nt);
spec_lungs = zeros(Nf,Nl); % initiate variable
snr_lungs = zeros(2,Nl);  % snr_lungs(1,:) = pyr_snr
noise_idx = [1:30,100:128];         % noise indices 

% Create masks and individual values of the metabolites. 
for ii = 1:Nl
    figure(253);
    spec_lungs(:,ii) = squeeze(img1(Nx-Yl(ii)+1,Ny-Xl(ii)+1,:));
    snr_lungs(1,ii) = sum(spec_lungs(pyr_idx,ii),1)/std(spec_lungs(noise_idx,ii),1);
    snr_lungs(2,ii) = sum(spec_lungs(lac_idx,ii),1)/std(spec_lungs(noise_idx,ii),1);
    % create a 3D mask (a stack of 2D mask, all the same mask)
    mask_lungs(Yl(ii),Xl(ii),:) = 1;
    
    subplot(Nxl,Nyl,ii); plot(real(spec_lungs(:,ii)));
    title(strcat(num2str(Xl(ii)),',',num2str(Yl(ii))));
    drawnow();
end

% plot sum of spectra over the lungs (acount for the ones that are zero)
sum_spec_lungs = squeeze(sum(sum(real(img1.*rot90(mask_lungs,2)),1),2))/Nl;
sum_pyr_snr_lungs = sum(sum_spec_lungs(pyr_idx))/std(sum_spec_lungs(noise_idx));
sum_lac_snr_lungs = sum(sum_spec_lungs(lac_idx))/std(sum_spec_lungs(noise_idx));
if show_lung_spectra
    figure(254);
    plot(cs,sum_spec_lungs); 
    set(gca, 'xdir','reverse')
    title('sum of spectra in the lungs');
    xlabel('chemical shift');
end
    

if use_fits_to_quantify
    % find invidual metabolite values in the selected voxels
    % rotate all images
    pyr_img = fliplr(rot90(squeeze(scaledimages(:,:,1))));
    bic_img = fliplr(rot90(squeeze(scaledimages(:,:,2))));
    ala_img = fliplr(rot90(squeeze(scaledimages(:,:,3))));
    lac_img = fliplr(rot90(squeeze(scaledimages(:,:,5))));
    
    % rescale fitted signal
    max_fit_image = max(pyr_img(:));
    pyr_img = pyr_img / max_fit_image * max_pyr_img;
    lac_img = lac_img / max_fit_image * max_pyr_img;
    bic_img = bic_img / max_fit_image * max_pyr_img;
    ala_img = ala_img / max_fit_image * max_pyr_img;
end

% create a 2D mask for quantification
mask_lungs = squeeze(mask_lungs(:,:,1));
% save this later for global quantification
global_mask = mask_lungs;

if average_then_integrate
    lac = sum(sum_spec_lungs(lac_idx));
    pyr = sum(sum_spec_lungs(pyr_idx));
    bic = sum(sum_spec_lungs(bic_idx));
    ala = sum(sum_spec_lungs(ala_idx));
else
    % makes sure that all selected voxels have postivie values
    lac = lac_img(:).*mask_lungs(:);
    pyr = pyr_img(:).*mask_lungs(:); pyr = pyr(lac>1e-5)';
    bic = bic_img(:).*mask_lungs(:); bic = bic(lac>1e-5)';
    ala = ala_img(:).*mask_lungs(:); ala = ala(lac>1e-5)';
    lac = lac(lac>1e-5)';
end

num_vox = round(length(lac(lac>1e-5)'));


if save_fig
    save_figure('lung_individual_spectra',[data_path '.fid/'],1,1,0)
end

if save_fig
    save_figure('lung_spectrum',[data_path '.fid/'],1,1,0)
end

% quantify lactate and pyruvate integrals in the lungs.
mets.lungs.pyr = pyr*max_signal;
mets.lungs.lac = lac*max_signal;
mets.lungs.ala = ala*max_signal;
mets.lungs.bic = bic*max_signal;
mets.lungs.lac2pyr = lac./pyr;
mets.lungs.ala2pyr = ala./pyr;
mets.lungs.lac2ala = lac./ala;


% save individual voxels
individual_voxels_csv_file = strcat(voxels_path,'individual_lung_voxels',data_path(end-1:end),'.csv');
fid = fopen(individual_voxels_csv_file,'w');
fprintf(fid,'%s, %s, %s, %s, %s, %s\n',...
    'x','y','lac','pyr','ala','bic');
fclose(fid); 
for ii = 1:num_vox
fid = fopen(individual_voxels_csv_file,'a');
fprintf(fid,'%1.0f, %1.0f, %4.4f, %4.4f, %4.4f\n, %4.4f\n',...
    Xl(ii),Yl(ii), mets.lungs.lac(ii), mets.lungs.pyr(ii),...
    mets.lungs.ala(ii), mets.lungs.bic(ii));
fclose(fid); 
end


% show all data
format long;
% show all data
format long;

fprintf('Voxles   Lac/Pyr     Ala/Pyr      Bic/Pyr     Bic/Lac     Lac/Ala \n');
fprintf('%2.0f       %4.4f     %4.4f      %4.4f     %4.4f     %4.4f\n\n',...
    Nl,mean(lac./pyr), mean(ala./pyr), mean(bic./pyr), mean(bic./lac), mean(lac./ala));

fprintf('Voxles   Lactate     Pyruvate     Alanine     Bicarbonate \n');
fprintf('%2.0f       %4.4f      %4.4f      %4.4f     %4.4f\n\n',...
    Nl,mean(lac)*max_signal, mean(pyr)*max_signal,...
    mean(ala)*max_signal, mean(bic)*max_signal);

fprintf('Voxles   Lac_Std     Pyr_Std      Ala_Std     Bic_Std \n');
fprintf('%2.0f       %4.4f      %4.4f       %4.4f      %4.4f\n\n',...
    Nl,std(lac)*max_signal, std(pyr)*max_signal,...
    std(ala)*max_signal, std(bic)*max_signal)

% Write to a CSV file for individual animal 
fid = fopen(voxels_csv_file,'a');
fprintf(fid,'%2.0f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f\n',...
    Nl,mean(lac)*max_signal,std(lac)*max_signal,...
    mean(pyr)*max_signal,std(pyr)*max_signal,...
    mean(ala)*max_signal,std(ala)*max_signal,...
    mean(bic)*max_signal,std(ala)*max_signal);
fclose(fid); 

% if flag 1 then add and append all data in one csv file
if combine_all_in_csv_flag
    csv_path = '/Users/mehipour/Documents/UPENN/Upenn Work/fMRI Lab/Projects/Hypoxia-Carbon-13/Data Analysis/R Analysis/Summary Data Matlab/';
    summary_csv_file = strcat(csv_path,'R_lung_global_data_',date,'.csv');

    % check if file exists
    if ~exist(summary_csv_file,'file') 
        % create file
        fid = fopen(summary_csv_file,'w');
            fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
         'rat', 'weight', 'cohort', 'injection', ...
         'lac', 'lac_std', 'pyr', 'pyr_std','ala','ala_std','bic','bic_std','spo2');
        fclose(fid);
    end
    
    fid = fopen(summary_csv_file,'a');
    fprintf(fid,'%1.0f, %1.0f, %s, %s, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.1f\n',...
    path(ll).rat_number, path(ll).weight, path(ll).cohort, ...
    path(ll).injection, ...
    mean(lac)*max_signal,std(lac)*max_signal,...
    mean(pyr)*max_signal,std(pyr)*max_signal,...
    mean(ala)*max_signal,std(ala)*max_signal,...
    mean(bic)*max_signal,std(ala)*max_signal,...
    path(ll).spo2);
    fclose(fid); 

end
