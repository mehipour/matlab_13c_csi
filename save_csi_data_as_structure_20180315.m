% save_csi_data_as_structure_date
%
% Made by MP on 6/24/17
%
% Update (1) by MP on 3/15/18
% if the flag save_structure_for_r = 1 then resizes all images to a vector
%

destination_folder = '/Users/mehipour/Documents/UPENN/Upenn Work/fMRI Lab/Projects/HCL-VILI-invivo/Analyzed Structs Lung Injury';

%
aux = strfind(path(ll).name,'rat');


% animal id
csi_data.animal_id = path(ll).name(aux+3:aux+4);

% injection number
if ~isempty(path(ll).injection)
    csi_data.injection = path(ll).injection;
else 
    csi_data.injection = 'inj1';
end

if ~save_structure_for_r
    % metabolite maps
    csi_data.maps.pyr = pyr_img;
    csi_data.maps.lac = lac_img;
    csi_data.maps.ala = ala_img;
    csi_data.maps.bic = bic_img;

    % masks
    csi_data.mask.lung = squeeze(global_mask);
    csi_data.mask.heart = squeeze(regional_mask(:,:,5));
    csi_data.mask.lungs.lp = squeeze(regional_mask(:,:,1));
    csi_data.mask.lungs.rp = squeeze(regional_mask(:,:,2));
    csi_data.mask.lungs.la = squeeze(regional_mask(:,:,3));
    csi_data.mask.lungs.ra = squeeze(regional_mask(:,:,4));

    % resized proton image
    csi_data.proton = interpolate_image(proton_cropped,[size(pyr_img)./size(proton_cropped)]);

else
    % metabolite maps
    csi_data.pyr = pyr_img(:);
    csi_data.lac = lac_img(:);
    csi_data.ala = ala_img(:);
    csi_data.bic = bic_img(:);

    % proton image
    csi_data.proton = proton_cropped(:);

end

filename = strcat(destination_folder,'/csi_data',csi_data.animal_id,'_',csi_data.injection,'.mat');

save(filename,'csi_data')



