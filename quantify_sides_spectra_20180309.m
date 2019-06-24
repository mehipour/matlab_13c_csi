%% quanitfy_sides_spectra_20180121
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
% side voxel files.
%
% update(5) on 10/19/2016 by MP, allows the user to select five regions in
% the chest (four side quadrants and the heart). Saves the values in a mat
% file as a struct and in a csv file. The number of voxels are saved now as
% well.
%
% Update (6) on 11/3/2016 by MP, modified for selection of the sides.
% This code uses the aboslute value of the peak
%
% Update (7) on 02/23/2017 by MP, easier to deal with file names
%
% Update (8) on 03/12/2017 by MP, renamed the file, now it deals with two
% sides, useful for quantifying the abnormal side and its contralateral
% side
%
% Update (9) on 06/21/2017 by MP, saves individual voxels as well
%
% update(10) on 01/21/2018 by MP:
% saves the alanine and bicarbonate values to the CSV file too.
%
% update(11) on 03/09/2018 by MP:
% it rescales the fitted imaging data to have the same maximum value as the
% images obtained from the area under the peak.
%
% update(12) on 07/29/2018 by MP:
% introduced the average_then_quantify flag. This allows quantification of
% metabolites in each region from the average of the spectra in that region
% rather. 




% find signal from the first spectrum acquired and scale the signal
gain = readprocpar(data_path, 'gain');
max_signal = sqrt(max(RE(:)).^2 + max(IM(:)).^2) / 2^(gain(2)/6);

% csi image with the non-normalized values
img1 = img*max_signal;

% Order of voxel selection: Left, Right
reg = ['Leftt';'Right'];

% check if lung voxels exists.
temp = strfind(data_path,'/');
voxels_path = data_path(1:temp(end-1)); 
% voxels_file = strcat(voxels_path,'lung_voxels',data_path(end-1:end),'_',reg(mm,:),'.mat');
voxels_file = strcat(voxels_path,'side_voxels',data_path(end-1:end),'.mat');

% check if voxels in the sides hv already been selected
if ~exist(voxels_file)
    % select the voxels over the sides 
    for mm = 1:2   % Region Loop
        fprintf('%s %s %s.....\n', 'select the',reg(mm,:),'side' )   
        if mrsi_voxel_selection
            if ~fov_match
                [Xl,Yl,Xp,Yp]=getspectra_click_20170313(img,proton_cropped,xgridshift,ygridshift);
            else
                [Xl,Yl,Xp,Yp]=getspectra_click_20170313(img,proton,xgridshift,ygridshift);
            end
            % if voxels are selected from the mrsi data then flip them.
            Yl = Nx-Yl+1;
            Xl = Nx-Xl+1;       
        else
            imagesc(pyr_img); axis square; colormap hot;
            [Xl,Yl] = getcarbonvoxel(pyr_img);
        end
        side_voxels.(strcat('Xp',reg(mm,:))) = Xp;
        side_voxels.(strcat('Yp',reg(mm,:))) = Yp;
        side_voxels.(strcat('X',reg(mm,:))) = Xl;
        side_voxels.(strcat('Y',reg(mm,:))) = Yl;
    end

    save(voxels_file,'side_voxels');
    
    if save_fig
       save_figure(strcat('csi_masked_sides',data_path(end-1:end)),voxels_path,1,1,0);
    end
else
    load(strcat(voxels_path,strcat('side_voxels',data_path(end-1:end),'.mat')));
end

%% Quantification
% quantify spectra in the sides and heart.

Nf = size(img,3); % number of points in each spectrum.

% open a csv file to write the values in.

voxels_csv_file = strcat(voxels_path,'side_voxels',data_path(end-1:end),'.csv');

fid = fopen(voxels_csv_file,'w');
fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
    'Reg.', 'No. of Voxels', 'Mean Lac', 'Std Lac', 'Mean Pyr', 'Std Pyr',...
    'Mean Ala', 'Std Ala', 'Mean Bic', 'Std Bic');
fclose(fid);

% start the file for regional inidividual metabolites
individual_side_voxels_csv_file = strcat(voxels_path,'individual_side_voxels',data_path(end-1:end),'.csv');
fid = fopen(individual_side_voxels_csv_file,'w');
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s\n',...
    'side','x','y','lac','pyr','ala','bic');
fclose(fid); 


% go through regions
for mm = 1:2
    
    % number of spectra in each section
    Nl = length(side_voxels.(strcat('X',reg(mm,:)))); 
    [Nxl,Nyl]=select_subplot_number(Nl); % select proper layout
    
    % read voxel coordinants of the 13C image
    Xl = side_voxels.(strcat('X',reg(mm,:)));
    Yl = side_voxels.(strcat('Y',reg(mm,:)));
    
    % read voxel coordinants of the 1H image
    Xp = side_voxels.(strcat('Xp',reg(mm,:)));
    Yp = side_voxels.(strcat('Yp',reg(mm,:)));
  

    % plot individual spectra with indicies and create a mask over the sides.
    mask_sides = zeros(Nx,Ny,Nt); % initiate variables
    spec_sides = zeros(Nf,Nl); 
    % Create masks and individual values of the metabolites. 
    for ii = 1:Nl
        spec_sides(:,ii) = squeeze(img1(Nx-Yl(ii)+1,Ny-Xl(ii)+1,:));
        % create a 3D mask (a stack of 2D mask, all the same mask)
        mask_sides(Yl(ii),Xl(ii),:) = 1;
        % Plot individual spectra
        if show_lung_spectra
            figure(253+mm);
            subplot(Nxl,Nyl,ii); plot(real(spec_sides(:,ii)));
            title(strcat(reg(mm,:),',',num2str(Xl(ii)),',',num2str(Yl(ii))));
            drawnow();
        end
    end
    % save figures of the inidivual spectra
    if and(save_fig,show_lung_spectra)
        save_figure(strcat('side_individual_spectra_',reg(mm,:)),[data_path '.fid/'],1,1,0)
    end
    
    % plot sum of spectra over each side (acount for the ones that are zero or not fitted)
    sum_spec_sides = squeeze(sum(sum(real(img1.*rot90(mask_sides,2)),1),2))/Nl;
    if show_lung_spectra
        figure(260+mm);
        plot(cs,sum_spec_sides); 
        set(gca, 'xdir','reverse')
        title(strcat('sum of spectra in ',reg(mm,:)));
        xlabel('chemical shift');
    end

    % find invidual metabolite values in the selected voxels using the fit
    % if wanted.
    % if 
    if use_fits_to_quantify
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
    
    % find invidual metabolite values in the selected voxels
    % This code uses the absolute value of the peaks.
    pyr_image = pyr_img;
    bic_image = bic_img;
    ala_image = ala_img;
    lac_image = lac_img; 

    % create a 2D mask for quantification
    mask_sides = squeeze(mask_sides(:,:,1));

    
    if average_then_integrate
        lac = sum(sum_spec_sides(lac_idx));
        pyr = sum(sum_spec_sides(pyr_idx));
        bic = sum(sum_spec_sides(bic_idx));
        ala = sum(sum_spec_sides(ala_idx));
    else
        % makes sure that all selected voxels have postivie values
        lac = lac_img(:).*mask_lungs(:);
        pyr = pyr_img(:).*mask_lungs(:); pyr = pyr(lac>1e-5)';
        bic = bic_img(:).*mask_lungs(:); bic = bic(lac>1e-5)';
        ala = ala_img(:).*mask_lungs(:); ala = ala(lac>1e-5)';
        lac = lac(lac>1e-5)';
    end

    % Save figure of the average spectrum
    if and(save_fig,show_lung_spectra)
        save_figure(strcat('side_spectrum_',reg(mm,:)),[data_path '.fid/'],1,1,0)
    end

    % quantify lactate and pyruvate integrals in the sides.
    mets.pyr.(reg(mm,:)) = pyr*max_signal;
    mets.lac.(reg(mm,:)) = lac*max_signal;
    mets.ala.(reg(mm,:)) = ala*max_signal;
    mets.bic.(reg(mm,:)) = bic*max_signal;
    mets.lac2pyr.(reg(mm,:)) = lac./pyr;
    mets.numberofvoxels.(reg(mm,:)) = Nl;
    
% 
%     for ii = 1:Nl     
%         fid = fopen(individual_side_voxels_csv_file,'a');
%         fprintf(fid,'%s,%1.0f,%1.0f, %4.4f, %4.4f, %4.4f,%4.4f\n',...
%             reg(mm,1),Xl(ii),Yl(ii),mets.lac.(reg(mm,:))(ii),...
%             mets.pyr.(reg(mm,:))(ii),mets.ala.(reg(mm,:))(ii),...
%             mets.bic.(reg(mm,:))(ii));
%         fclose(fid); 
%     end

%     % quanitfy proton images
%     if ~fov_match
%         proton1 = proton_cropped;
%     else
%         proton1 = proton;
%     end
%     [nx,ny] = size(proton1);
%     % line up all the proton voxels
%     proton_voxels = [];
%     for pp = 1:num_vox;
%         dum = proton1(ny-Yp(2,pp)+1:ny-Yp(1,pp)+1,Xp(1,pp):Xp(2,pp));
%         proton_voxels = [proton_voxels; dum(:)]; 
%     end
%     mets.pd.(reg(mm,:)) = proton_voxels;
%     
%     fprintf('%s %s %s.....\n', 'Show the values for the',reg(mm,:),'area:');
%     ['lac2pyr    ' 'lactate     ' 'pyruvate   '  'PD     '      '# of voxels   ' 'signal  ']
%     [mean(lac./pyr) mean(lac)*max_signal mean(pyr)*max_signal mean(proton_voxels)  num_vox max_signal ]
%     [std(lac./pyr) std(lac)*max_signal std(pyr)*max_signal std(proton_voxels)]
%     fprintf('\n');
%     
%     % Write to a CSV file
%     fid = fopen(voxels_csv_file,'a');
%     fprintf(fid,'%s, %2.0f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f\n',reg(mm,:),...
%         num_vox,mean(lac)*max_signal,std(lac)*max_signal,...
%         mean(pyr)*max_signal,std(pyr)*max_signal,mean(proton_voxels),std(proton_voxels));
%     fclose(fid); 
%     
        fprintf('%s %s %s.....\n\n', 'Show the values for the',reg(mm,:),'area:');
        
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
            std(ala)*max_signal, std(bic)*max_signal);
        
%     ['lac2pyr    ' 'lactate     ' 'pyruvate   '  '# of voxels   ' 'signal  ']
%     [mean(lac./pyr) mean(lac)*max_signal mean(pyr)*max_signal  num_vox max_signal ]
%     [std(lac./pyr) std(lac)*max_signal std(pyr)*max_signal]
%     fprintf('\n');
    
    % Write to a CSV file
    fid = fopen(voxels_csv_file,'a');
    fprintf(fid,'%s, %2.0f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f\n',reg(mm,:),...
         Nl,mean(lac)*max_signal,std(lac)*max_signal,...
        mean(pyr)*max_signal,std(pyr)*max_signal,...
        mean(ala)*max_signal,std(ala)*max_signal,...
        mean(bic)*max_signal,std(bic)*max_signal);
    fclose(fid); 
    
    
    
    
    % rearrange to match steve's code
    scaledimages = zeros(16,16,9);
    scaledimages(:,:,1) = rot90(fliplr(pyr_img),3);
    scaledimages(:,:,2) = rot90(fliplr(bic_img),3);
    scaledimages(:,:,3) = rot90(fliplr(ala_img),3);
    scaledimages(:,:,5) = rot90(fliplr(lac_img),3);
end


