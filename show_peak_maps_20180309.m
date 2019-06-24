% show_carbon_maps_20161206
% this is a nested code in the process_c13_2016.... code that will show the
% metabolite maps if show_maps is set to a non-zero value.
%
% Update (1) by Mehrdad Pourfathi, to have the option to generate maps from
% taking the area under the magnitude peaks or real peaks based on the
% selected flag.
%
% Update (2) by Mehrdad Pourfathi, adds colorbar to lac2pyr and ala2pyr
% maps.
%
% Update (3) by Mehrdad Pourfathi, on 2017/01/24
% renamed to show_peak_maps and gives the options to change the labels for
% the xenon images. 
%
% Update (4) by Mehrdad Pourfathi, on 2017/02/21
% lactate-to-pyruvate and alanine-to-pyruvate images are scaled to their
% maximum value and colorbars are added. also added a mask
%
% Update (5) by Mehrdad Pourfathi, on 2017/03/03
% can also mask based on the proton scan, carbon scan, "nand" or "or
% combination of scans the masks
%
% Update (6) by Mehrdad Pourfathi, on 2017/03/06
% if fits are used for quantification, use them also to generate maps.
%
% Update (7) by Mehrdad Pourfathi, on 2017/03/08
% if lactate is bigger than pyruvate, change the maximum lac2pyr ratio map
% limit, also limits metabolites maps generated from fits to positive
% values.
%
% Update (8) by Mehrdad Pourfathi, on 2017/03/08
% if lactate is bigger than pyruvate, change the maximum lac2pyr ratio map
% limit, also limits metabolites maps generated from fits to positive
% values.
%
% Update (9) by Mehrdad Pourfathi, on 07/02/2017
% Manual mask selection
% also multiples all the scaledimages data by the first point in the FID to
% get the true signal. 
%
% Update (10) by Mehrdad Pourfathi, on 02/08/2018
% Puts all images in the maps structure that contains the image and the
% metabolite name. It is the called in the
% "quantify_segmented_maps_date..." function for quantificiation.
%
% Update (11) by Mehrdad Pourfathi, on 03/09/2018
% when using the fits to create maps, it still generates the pyr_img from
% the area under the peak and calculates its maximum value. It will use
% this value later in the quantificaiton function.


signal = abs(RE(1)+1i*IM(1));

figure(121)

% disk size for morphological closing
se = strel('disk',closing_disk_size);

if show_real_mrsi
    % pyruvate image
    if use_fits_to_quantify
        pyr_img = fliplr(rot90(scaledimages(:,:,1)*signal));
        pyr_img_integral = flipud((fliplr(sum(img(:,:,pyr_idx),3))));
        max_pyr_img = max(pyr_img_integral(:));
    else
        pyr_img = flipud((fliplr(sum(img(:,:,pyr_idx),3))));
    end
    subplot(231);
    pyr_imgi = interpolate_image(pyr_img,Ni_maps);

    if xenon
        title('gas phase')
    else
        title('pyruvate map');
    end
    
    if mask_ratio_images
        if ~use_previous_mask            
            if manual_mask
                manual_mask_selection_csi_20170702();
                figure(121);  % go back to the figure;
            else
                if and(proton_mask,carbon_mask)
                    protoni = interpolate_image(proton_cropped,length((pyr_imgi))/length(proton_cropped));
                    mask1 = protoni>proton_mask_threshold*max(protoni(:));
                    mask2 = pyr_imgi>carbon_mask_threshold*max(pyr_imgi(:));
                    if nand_mask_combination
                        mask = and(not(mask1),mask2);
    %                     mask = imclose(mask,se);
                    else
                        mask = or(mask1,mask2);
                    end
                elseif proton_mask
                    protoni = interpolate_image(proton_cropped,length((pyr_imgi))/length(proton_cropped));
                    mask = protoni>proton_mask_threshold*max(protoni(:));
                elseif carbon_mask
                    mask = pyr_imgi>carbon_mask_threshold*max(pyr_imgi(:));
                end
                mask = imclose(mask,se);
            end
        end
    else
        mask = ones(size(pyr_imgi));
    end
    
    % if metabolite images are to be masked too.
    if mask_met_images
        pyr_imgi = pyr_imgi.*mask;
    end
    imagesc(pyr_imgi);
    axis square;
    caxis([0 max(max(pyr_imgi.*mask))]);
    
    % lactate image
    if use_fits_to_quantify
        lac_img = fliplr(rot90(scaledimages(:,:,5)*signal));
    else
        lac_img = flipud((fliplr(sum(img(:,:,lac_idx),3))));
    end
    subplot(232);
    lac_imgi = interpolate_image(lac_img,Ni_maps);
    if mask_met_images
        lac_imgi = lac_imgi.*mask;
    end
    imagesc(lac_imgi);
    axis square;
    caxis([0 max(max(lac_imgi.*mask))]);

    if xenon
        title('tissue-phase')
    else
        title('lactate map');
    end

    % alanine image
    if use_fits_to_quantify
        ala_img = fliplr(rot90(scaledimages(:,:,3)*signal));
    else
        ala_img = flipud((fliplr(sum(img(:,:,ala_idx),3))));
    end
    subplot(233);
    ala_imgi = interpolate_image(ala_img,Ni_maps);
    if mask_met_images
        ala_imgi = ala_imgi.*mask;
    end
    imagesc(ala_imgi);
    axis square;
    caxis([0 max(max(ala_imgi.*mask))]);
    if xenon
        title('RBC-phase')
    else
        title('alanine map');
    end

    % bicarbonate image
    if use_fits_to_quantify
        bic_img = fliplr(rot90(scaledimages(:,:,2)*signal));
    else
        bic_img = flipud((fliplr(sum(img(:,:,bic_idx),3))));
    end
    subplot(234);
    bic_imgi = interpolate_image(bic_img,Ni_maps);
    if mask_met_images
        bic_imgi = bic_imgi.*mask;
    end
    imagesc(bic_imgi);
    axis square;
    caxis([0 max(max(bic_imgi.*mask))]);

    if xenon
        title('just noise')
    else
        title('bicarbonate map');
    end

    % lac2pyr image
    lac2pyr = lac_img ./ pyr_img;
    subplot(235);
    lac2pyri = interpolate_image(lac2pyr,Ni_maps);
    imagesc(lac2pyri.*mask);
    axis square;
    colorbar;
    if xenon
        title('tissue/gas');
    else
        title('lac/pyr map');
    end
    if lac_bigger_than_pyr
        caxis([0 min(max(max(lac2pyri.*mask)),5)]);
    else
        caxis([0 min(max(max(lac2pyri.*mask)),1)]);
    end
    colorbar;

    % ala2pyr image
    ala2pyr = ala_img ./ pyr_img;
    subplot(236);
    ala2pyri = interpolate_image(ala2pyr,Ni_maps);
    imagesc(ala2pyri.*mask);
    axis square; 
    colorbar;
    if xenon
        title('RBC/gas');
    else
        title('ala/pyr map');
    end
    colorbar;
    if lac_bigger_than_pyr
        caxis([0 min(max(max(lac2pyri.*mask)),5)]);
    else
        caxis([0 min(max(max(lac2pyri.*mask)),1)]);
    end
    
elseif show_norm_mrsi
    % pyruvate or gas phase image
    pyr_img = flipud((fliplr(sum(abs(img_abs(:,:,pyr_idx)),3))));
    subplot(231);
    pyr_imgi = interpolate_image(pyr_img,Ni_maps);
    imagesc(pyr_imgi);
    axis square;
    if xenon
        title('gas phase')
    else
        title('pyruvate map');
    end
    if mask_ratio_images
        if ~use_previous_mask
            if manual_mask
                manual_mask_selection_csi_20170702();
            else
                if and(proton_mask,carbon_mask)
                    protoni = interpolate_image(proton_cropped,length((pyr_imgi))/length(proton_cropped));
                    mask1 = protoni>proton_mask_threshold*max(protoni(:));
                    mask2 = pyr_imgi>carbon_mask_threshold*max(pyr_imgi(:));
                    if nand_mask_combination
                        mask = and(not(mask1),mask2);
                    else
                        mask = or(mask1,mask2);
                    end
                elseif proton_mask
                    protoni = interpolate_image(proton_cropped,length((pyr_imgi))/length(proton_cropped));
                    mask = protoni>proton_mask_threshold*max(protoni(:));
                elseif carbon_mask
                    mask = pyr_imgi>carbon_mask_threshold*max(pyr_imgi(:));
                end
                mask = imclose(mask,se);
            end
        end
    else
        mask = ones(size(pyr_imgi));
    end
    
    % lactate or tissue-phase image
    lac_img = flipud((fliplr(sum(abs(img_abs(:,:,lac_idx)),3))));
    subplot(232);
    lac_imgi = interpolate_image(lac_img,Ni_maps);
    imagesc(lac_imgi); 
    axis square;
    if xenon
        title('tissue-phase')
    else
        title('lactate map');
    end
    
    % alanine or RBC-phase image
    ala_img = flipud((fliplr(sum(abs(img_abs(:,:,ala_idx)),3))));
    subplot(233);
    ala_imgi = interpolate_image(ala_img,Ni_maps);
    imagesc(ala_imgi); 
    axis square;
    if xenon
        title('RBC-phase')
    else
        title('alanine map');
    end
    
    % bicarbonate image
    subplot(234);
    if xenon
        rbc2tis = ala_img ./ lac_img;
        rbc2tisi = interpolate_image(rbc2tis,Ni_maps);
        imagesc(rbc2tisi.*mask); 
        title('rbc/tissue')
    else
        bic_img = flipud((fliplr(sum(abs(img_abs(:,:,bic_idx)),3))));
        bic_imgi = interpolate_image(bic_img,Ni_maps);
        imagesc(bic_imgi); 
        title('bicarbonate map');
    end
    axis square;
    
    % lac2pyr or tissue2gas image
    lac2pyr = lac_img ./ pyr_img;
    subplot(235);
    lac2pyri = interpolate_image(lac2pyr,Ni_maps);
    imagesc(lac2pyri.*mask); 
    axis square;
    if xenon
        title('tissue/gas');
    else
        title('lac/pyr map');
    end
%     caxis([0 max(max(lac2pyri.*mask))]);
    colorbar;

    % ala2pyr image
    ala2pyr = ala_img ./ pyr_img;
    subplot(236);
    ala2pyri = interpolate_image(ala2pyr,Ni_maps);
    imagesc(ala2pyri.*mask); 
    axis square;
    if xenon
        title('RBC/gas');
    else
        title('ala/pyr map');
    end
%     caxis([0 max(max(ala2pyri.*mask))]);
    colorbar;
end

colormap jet;

if save_fig
    save_figure('maps',[data_path '.fid/'],1,1,0)
end


% put all images in a stucture
met_maps = struct('metabolite','','map','');
met_maps(1).metabolite = 'pyruvate';
met_maps(1).map = pyr_imgi;
met_maps(2).metabolite = 'lactate';
met_maps(2).map = lac_imgi;
met_maps(3).metabolite = 'alanine';
met_maps(3).map = ala_imgi;
met_maps(4).metabolite = 'bicarbonate';
met_maps(4).map = bic_imgi;

