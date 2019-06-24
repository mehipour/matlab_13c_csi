% quantify_masked_lung_regions_20180208

%
% quantifies regions of the lung, heart and muscle that are selected by segmentation
%
% code is based on manual_mask_selection_csi_20170702 made on 7/2/2017 by
% MP


%% Quantification Mask Selection and Loading
% define folder path to save quantification data
temp = strfind(data_path,'/');
quantify_path = data_path(1:temp(end-1));
quantify_file = strcat(quantify_path,'mask/quantify_file',data_path(end-1:end),'.mat');

% define structure
quantify_mask = struct('region','','mask','','mets','','area','');

% define regions
regions = {'heart', 'PL lung','PR lung', 'AL lung', 'AR lung', 'muscle'};

% check if the quantification file already exists
if ~exist(quantify_file,'file')
    
    % use the overlaid pyruvate map
    figure(1543);

    
    % loop over the regions
    for region_loop = 1:length(regions)

        % write the region in the structure
        quantify_mask(region_loop).region = cell2mat(regions(region_loop));
        
        % print the region to be selected
        fprintf(['select the ',cell2mat(regions(region_loop)),' region\n']); 
        
        % select the region
        subplot(221);
        [m,x,y] = roipoly;
        quantify_mask(region_loop).mask = double(m);
        
        % draw the roi on pyruvate and lactate images
        hold on; 
        plot(x,y,'w.-','MarkerSize',25,'LineWidth',2);
        
        subplot(222);
        hold on; 
        plot(x,y,'w.-','MarkerSize',25,'LineWidth',2);
        
        % make all zeros equal to NaN      
        quantify_mask(region_loop).mask(quantify_mask(region_loop).mask==0) = NaN;
        
        % find area of region
        aux = quantify_mask(region_loop).mask;
        quantify_mask(region_loop).area = nansum(aux(:));
       
    end
    
    % check if the mask folder already exists, if not create it.
    if ~exist([quantify_path,'mask'],'dir')
        mkdir(quantify_path,'mask');
    end
    
    % save rois in the figure 
    if save_fig
        save_figure(strcat('roi_',data_path(end-1:end)),[quantify_path,'mask/'],1,1,0);
    end
    
    
    % save masks
    save(quantify_file,'quantify_mask');
else
    % if the quantificaiton mask exists, load the file
    load(quantify_file);
end


%% Quantification

% create metabolite stucture. this is an element of the quantify_mask structure
mets = struct('metabolite','','mean','','std','');
% create list of metabolites
metabolites = {'pyruvate','lactate','alanine','bicarbonate'};

% find signal from the first spectrum acquired and scale the signal
gain = readprocpar(data_path, 'gain');
max_signal = sqrt(max(RE(:)).^2 + max(IM(:)).^2) / 2^(gain(2)/6);

for region_loop = 1:length(regions)
    
    for metabolite_loop = 1:length(metabolites)
    
        quantify_mask(region_loop).mets(metabolite_loop).metabolite = cell2mat(metabolites(metabolite_loop)); 
        
        aux = met_maps(metabolite_loop).map .* quantify_mask(region_loop).mask;
        quantify_mask(region_loop).mets(metabolite_loop).mean = nanmean(aux(:))*max_signal;
        quantify_mask(region_loop).mets(metabolite_loop).std = nanstd(aux(:))*max_signal;
    end
    
    area = quantify_mask(region_loop).area;
    lac2pyr = quantify_mask(region_loop).mets(2).mean/quantify_mask(region_loop).mets(1).mean;
    ala2pyr = quantify_mask(region_loop).mets(3).mean/quantify_mask(region_loop).mets(1).mean;
    bic2pyr = quantify_mask(region_loop).mets(4).mean/quantify_mask(region_loop).mets(1).mean;
    bic2lac = quantify_mask(region_loop).mets(4).mean/quantify_mask(region_loop).mets(2).mean;
    lac2ala = quantify_mask(region_loop).mets(2).mean/quantify_mask(region_loop).mets(3).mean;

    fprintf('%s %s %s.....\n\n', 'Show the values for the ',quantify_mask(region_loop).region,' area:');

    fprintf('Area   Lac/Pyr     Ala/Pyr      Bic/Pyr     Bic/Lac     Lac/Ala \n');
    fprintf('%2.0f       %4.4f     %4.4f      %4.4f     %4.4f     %4.4f\n\n',...
        area, lac2pyr, ala2pyr, bic2pyr, bic2lac, lac2ala);

    fprintf('Voxles   Lactate     Pyruvate     Alanine     Bicarbonate \n');
    fprintf('%2.0f       %4.4f      %4.4f      %4.4f     %4.4f\n\n',...
        area, quantify_mask(region_loop).mets(2).mean,...
        quantify_mask(region_loop).mets(1).mean,...
        quantify_mask(region_loop).mets(3).mean,...
        quantify_mask(region_loop).mets(4).mean);

    fprintf('Voxles   Lac_Std     Pyr_Std      Ala_Std     Bic_Std \n');
    fprintf('%2.0f       %4.4f      %4.4f       %4.4f      %4.4f\n\n',...
        area, quantify_mask(region_loop).mets(2).std,...
        quantify_mask(region_loop).mets(1).std,...
        quantify_mask(region_loop).mets(3).std,...
        quantify_mask(region_loop).mets(4).std);

end



