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
%
% Update (12) by Mehrdad Pourfathi, on 10/24/2018
% used to show dynamic images. it changes the figure number (121+image_num)
% Also it took out xenon handlers and masking capabilities.

signal = abs(RE(1)+1i*IM(1));

figure(120+image_num)

if show_real_mrsi
    % pyruvate image
    if use_fits_to_quantify
        pyr_img(:,:,image_num) = fliplr(rot90(scaledimages(:,:,1)*signal));
        pyr_img_integral = flipud((fliplr(sum(img(:,:,pyr_idx),3))));
        max_pyr_img = max(pyr_img_integral(:));
    else
        pyr_img(:,:,image_num) = flipud((fliplr(sum(img(:,:,pyr_idx),3))));
    end
    subplot(231);
    pyr_imgi = interpolate_image(pyr_img(:,:,image_num),Ni_maps);
    imagesc(pyr_imgi);
    title(num2str(image_num));
    axis square;
    caxis([0 max(max(pyr_imgi))]);
    
    % lactate image
    if use_fits_to_quantify
        lac_img(:,:,image_num) = fliplr(rot90(scaledimages(:,:,5)*signal));
    else
        lac_img(:,:,image_num) = flipud((fliplr(sum(img(:,:,lac_idx),3))));
    end
    subplot(232);
    lac_imgi = interpolate_image(lac_img(:,:,image_num),Ni_maps);
    imagesc(lac_imgi);
    axis square;
    caxis([0 max(max(lac_imgi))]);

    title('lactate map');

    % alanine image
    if use_fits_to_quantify
        ala_img(:,:,image_num) = fliplr(rot90(scaledimages(:,:,3)*signal));
    else
        ala_img(:,:,image_num) = flipud((fliplr(sum(img(:,:,ala_idx),3))));
    end
    subplot(233);
    ala_imgi = interpolate_image(ala_img(:,:,image_num),Ni_maps);
    imagesc(ala_imgi);
    axis square;
    caxis([0 max(max(ala_imgi))]);
    title('alanine map');

    % bicarbonate image
    if use_fits_to_quantify
        bic_img(:,:,image_num) = fliplr(rot90(scaledimages(:,:,2)*signal));
    else
        bic_img(:,:,image_num) = flipud((fliplr(sum(img(:,:,bic_idx),3))));
    end
    subplot(234);
    bic_imgi = interpolate_image(bic_img(:,:,image_num),Ni_maps);
    imagesc(bic_imgi);
    axis square;
    caxis([0 max(max(bic_imgi))]);
    title('bicarbonate map');

    % lac2pyr image
    lac2pyr = squeeze(lac_img(:,:,image_num) ./ pyr_img(:,:,image_num));
    subplot(235);
    lac2pyri = interpolate_image(lac2pyr,Ni_maps);
    imagesc(lac2pyri);
    axis square;
    title('lac/pyr map');

    if lac_bigger_than_pyr
        caxis([0 min(max(max(lac2pyri)),5)]);
    else
        caxis([0 min(max(max(lac2pyri)),1)]);
    end
    colorbar;

    % ala2pyr image
    ala2pyr = squeeze(ala_img(:,:,image_num) ./ pyr_img(:,:,image_num));
    subplot(236);
    ala2pyri = interpolate_image(ala2pyr,Ni_maps);
    imagesc(ala2pyri);
    axis square; 
    colorbar;
    title('ala/pyr map');
    if lac_bigger_than_pyr
        caxis([0 min(max(max(lac2pyri)),5)]);
    else
        caxis([0 min(max(max(lac2pyri)),1)]);
    end
    
elseif show_norm_mrsi
    % pyruvate or gas phase image
    pyr_img(:,:,image_num) = flipud((fliplr(sum(abs(img(:,:,pyr_idx)),3))));
    subplot(231);
    pyr_imgi = interpolate_image(pyr_img(:,:,image_num),Ni_maps);
    imagesc(pyr_imgi);
    title(num2str(image_num));
    axis square;
    
    % lactate or tissue-phase image
    lac_img(:,:,image_num) = flipud((fliplr(sum(abs(img(:,:,lac_idx)),3))));
    subplot(232);
    lac_imgi = interpolate_image(lac_img(:,:,image_num),Ni_maps);
    imagesc(lac_imgi); 
    title('lactate map');
    
    % alanine or RBC-phase image
    ala_img(:,:,image_num) = flipud((fliplr(sum(abs(img(:,:,ala_idx)),3))));
    subplot(233);
    ala_imgi = interpolate_image(ala_img(:,:,image_num),Ni_maps);
    imagesc(ala_imgi); 
    title('alanine map');
    
    % bicarbonate image
    subplot(234);
    bic_img(:,:,image_num) = flipud((fliplr(sum(abs(img(:,:,bic_idx)),3))));
    bic_imgi = interpolate_image(bic_img(:,:,image_num),Ni_maps);
    imagesc(bic_imgi); 
    title('bicarbonate map');
    axis square;
    
    % lac2pyr or tissue2gas image
    lac2pyr = squeeze(lac_img(:,:,image_num) ./ pyr_img(:,:,image_num));
    subplot(235);
    lac2pyri = interpolate_image(lac2pyr,Ni_maps);
    imagesc(lac2pyri); 
    axis square;
    title('lac/pyr map');
    colorbar;

    % ala2pyr image
    ala2pyr = squeeze(ala_img(:,:,image_num) ./ pyr_img(:,:,image_num));
    subplot(236);
    ala2pyri = interpolate_image(ala2pyr,Ni_maps);
    imagesc(ala2pyri); 
    axis square;
    title('ala/pyr map');
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

