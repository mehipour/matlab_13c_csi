% process_dce_20160309
% file created by Mehrdad Pourfathi on 3/9/16
%
% update (1) by MP on 3/11/16
% use the polygon roi function in matlab to select roi.

clear all; close all; clc;

% if 1 then show video. 
show_video = 0;

% set flags
save_fig = 1;      % flag to save ".png" and ".fig" images
show_images = 1;   % flag to show the images in matlab.
Nstart = 1;       % index of the first image in montage
Ninc = 1;          % increment of the image index in motange
Nend = 200;        % index of the lat image in montage.

% set path
% path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160317_rat39hcl_dce/gd1/dce_gre_fast_03.img/';
% path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20161103_mouse102_kidney/s_2016110302/dce_gre_01.img/';
% path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160311_rat37hcl_dce/gd3/dce_gre_fast_07.img/';
% path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160314_rat38hcl_dce/gd1/dce_gre_fast_02.img/';

% path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160317_rat39hcl_dce/gd1/dce_gre_fast_03.img/';
% path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160317_rat39hcl_dce/gd2/dce_gre_fast_05.img/';
% path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160408_rat306_mri/gd1/dce_gre_fast_02.img/';
path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160420_transrat_003_mri_03/gd1/dce_gre_02.img/';
% path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20161021_mouse01_kidney/s_2016102101/dce_gre_01.img/';

jj = 0; % reset file counter
file_h = dir(path);

% if images.mat file exists load the images and masks otherwise read the
% fdf files and have the user manually select ROIs.
if exist([path 'images.mat'])
    load([path 'images'])
else    
    for ii = 1:numel(file_h)
        if ~isempty(strfind(file_h(ii).name,'slice'))
            jj = jj + 1;  % if the file name included 'slice'
            path1 = [path file_h(ii).name];
            h(:,:,jj) = fdf2(path1);
        end
    end

    %% ROI selection:
    % the order is right ventricle, right lung, left lung and left ventricle. 
    figure(323);
    
    % show the image used for manual segmentation. 
    img = sum(h(:,:,100:100),3); 
    imagesc(img); axis square;
    caxis([1 2E3]);

    fprintf('select the right ventricle\n');    
    rvmask = double(roipoly);
    rvmask(rvmask==0) = NaN;

    fprintf('select the right lung\n');
    rlmask = double(roipoly);
    rlmask(rlmask==0) = NaN;

    fprintf('select the left lung\n');
    llmask = double(roipoly);
    llmask(llmask==0) = NaN;

    fprintf('select the left ventricle\n');
    lvmask = double(roipoly);
    lvmask(lvmask==0) = NaN;

    % save images and masks.
    save([path 'images.mat'],'h','rvmask','rlmask','llmask','lvmask');
end

%% find the mean values in the left and right venctricles. 
clear srv srl sll slv t
Nimg = 200;    % number of images to load.

% average this many images when plotting the time course.
Navg = 1;
jj = 0; % reset image counter.

for ii = 1:Navg:Nimg
    jj = jj+1;
    hrv = squeeze(mean(h(:,:,ii:ii+Navg-1),3).*rvmask);
    srv(jj) = nanmean(hrv(:));
    hrl = squeeze(mean(h(:,:,ii:ii+Navg-1),3).*rlmask);
    srl(jj) = nanmean(hrl(:));    
    hll = squeeze(mean(h(:,:,ii:ii+Navg-1),3).*llmask);
    sll(jj) = nanmean(hll(:));
    hlv = squeeze(mean(h(:,:,ii:ii+Navg-1),3).*lvmask);
    slv(jj) = nanmean(hlv(:));
end

srv = srv';
srl = srl';
sll = sll';
slv = slv';

% find time per image and generate time vector.
nv = readprocpar(path(1:end-5),'nv'); nv = nv(2);
tr = readprocpar(path(1:end-5),'tr'); tr = tr(2);
ti = nv*tr;
t = linspace(0,ti*Nimg,length(sll))';

% show dynamic graphs.
figure(324); clf;
plot(t,srv,'o-',t,srl,'*-',t,sll,'s-',t,slv,'.-'); 
legend('right ventricle','right lung','left lung','left ventricle');
xlabel('Time (s)'); box off;

% save figures
if save_fig
    save_figure('dce_gd',path,1,1,0);
end


%% show images
if show_images
    jj = 0; % reset counter.
    % rearrange images and subtract mean of the first 5 images for
    % "montage" function.
    for ii = Nstart:Ninc:Nend
        jj = jj+1;
        h1(:,:,1,jj) = h(:,:,ii)-mean(h(:,:,Nstart:Nstart+5),3);
        h2(:,:,1,jj) = h(:,:,ii);
    end
    
    % show and save the subtracted images.
    figure(345); 
    montage((uint16(h1)));
    caxis([0 2000])
    title(strcat('subtracted from',num2str(Nstart*ti),'s to ', num2str(Nend*ti),'s with',num2str(Ninc*ti),'s resolution'))
    if save_fig
        save_figure('dce_images_subtracted',path,1,1,0);
    end  
    
    % show and save the actual images.
    figure(346); 
    montage((uint16(h2)));
    caxis([0 1000])
    title(strcat('original from',num2str(Nstart*ti),'s to ', num2str(Nend*ti),'s with',num2str(Ninc*ti),'s resolution'))
    if save_fig
        save_figure('dce_images_original',path,1,1,0);
    end  
end


%% Show video
if show_video
    figure(10);
    for ii = 1:100
        h3(:,:,ii) = h(:,:,ii) - mean(h(:,:,1:5),3);
    end
    for ii = 1:100
        subplot(121); imagesc(squeeze(h(:,:,ii))); colormap gray; axis square;
        caxis([0 0.3*max(h(:))])
        subplot(122); imagesc(squeeze(h3(:,:,ii))); colormap gray; axis square;
        caxis([0 0.3*max(h3(:))])
        pause(0.1);
    end
end
