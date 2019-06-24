% manual mask selection
% 
% Created by MP on 7/2/2017
%
% note that the interpolation factor (Ni_Maps) should be such that the
% carbon image and the area it covers on the proton image have the same
% number of pixels.

temp = strfind(data_path,'/');
mask_path = data_path(1:temp(end-1));
mask_file = strcat(mask_path,'mask/mask_file',data_path(end-1:end),'.mat');

if ~exist(mask_file)
    figure(6534);
    imagesc(proton_cropped); colormap gray; axis square;
    title('select mask')

    fprintf('select the left lung\n');    
    llmask = double(roipoly);

    fprintf('select the right lung\n');    
    rlmask = double(roipoly);

    mask = double(or(rlmask,llmask));

    mask(mask==0) = NaN;
    
    if ~exist(mask_file,'dir')
        mkdir(mask_path,'mask');
    end
    save(mask_file,'mask','llmask','rlmask');
else
    load(mask_file);
    endli
