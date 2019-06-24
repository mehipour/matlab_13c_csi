% Code for segmentation and T2star measurement of kidneys from a multi-echo
% gradient echo sequence. 
%  
% Scanner type: Varian
% 
% Code written by Mehrdad Pourfathi on 07/07/2016
%
% Update (1), on 07/10/2016:
%           changed whole kidney segmetnation to whole kidney, cortex and medulla
%           segmentations.

image_path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160712_rat3vili_kidney/s_2016071201/mge_bold_03.img/';  % inj1
% image_path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160707_rat2vili_kidney/s_2016070702/mge_bold_03.img/';  % inj2
% image_path = '/Volumes/Macintosh HD 1/Data/HUP-C data/20160707_rat2vili_kidney/s_2016070702/mge_bold_06.img/';  % inj3


ns = 3;    % number of slices
ne = 10;   % number of echoes
te = 2;    % echo time in ms
dte = 2.6; % echo spacing
os = 3;    % observed slice
sege =8;   % segmented echo image

t = linspace(te,te+(ne-1)*dte,ne);


% if images.mat file exists load the images and masks otherwise read the
% fdf files and have the user manually select ROIs.
if exist([image_path 't2star_images.mat'])
    load([image_path 't2star_images'])
else    

    %% Open proton images
    jj = 0; % reset file counter
    file_h = dir(image_path);
    for ii = 1:numel(file_h)
        if ~isempty(strfind(file_h(ii).name,'slice'))
            jj = jj + 1;  % if the file name included 'slice'
    %         disp(file_h(ii).name)
            path1 = [image_path file_h(ii).name];
            h(:,:,jj) = fdf2(path1);
            h1(:,:,1,jj) = h(:,:,jj);
        end
    %     save_figure('proton',proton_image_path,1,1,0)
    end

    %% rearrange matrix
    h2 = zeros(size(h,1),size(h,2),ne,ns);
    % rearrange images
    for ii = 1:ns
        for jj = 1:ne
            idx = (ii-1)*ne+jj;
            h2(:,:,jj,ii) = h(:,:,idx);   
        end 
    end
    
    %% ROI selection:
    % the order is right ventricle, right lung, left lung and left ventricle. 
    figure(323);
    
    % show the image used for manual segmentation. 
    img = h2(:,:,sege,os); 
    imagesc(img); axis square; colormap gray;
%     caxis([1 2E4]);

    fprintf('select left kidney \n');
    lmask = double(roipoly);
    
    fprintf('select left kidney medulla\n');
    lmmask = double(roipoly);
    
    lcmask = lmask - lmmask;   % left cortex

    fprintf('select right kidney \n');
    rmask = double(roipoly);
    
    fprintf('select right kidney medulla\n');
    rmmask = double(roipoly);

    rcmask = rmask - rmmask;   % right cortex

    lmask(lmask==0) = NaN;
    lmmask(lmmask==0) = NaN;
    lcmask(lcmask==0) = NaN;
    rmask(rmask==0) = NaN;
    rmmask(rmmask==0) = NaN;
    rcmask(rcmask==0) = NaN;

    % save images and masks.
    save([image_path 't2star_images.mat'],'h1','h2','lmask','lmmask','lcmask','rmask','rmmask','rcmask');

end

%% plot all images and save figure
figure(123);
montage(uint16(h1));
caxis([0 max(h1(:))/1.2]);
save_figure('t2star_images',image_path,1,1,0);


%% 
for ii = 1:ne
    % left kidney signal
    hl = squeeze(h2(:,:,ii,os)).*lmask;
    sl(ii) = nanmean(hl(:));
    hlm = squeeze(h2(:,:,ii,os)).*lmmask;
    slm(ii) = nanmean(hlm(:)); 
    hlc = squeeze(h2(:,:,ii,os)).*lcmask;
    slc(ii) = nanmean(hlc(:)); 
    % right kidney signal
    hr = squeeze(h2(:,:,ii,os)).*rmask;
    sr(ii) = nanmean(hr(:));
    hrm = squeeze(h2(:,:,ii,os)).*rmmask;
    srm(ii) = nanmean(hrm(:)); 
    hrc = squeeze(h2(:,:,ii,os)).*rcmask;
    src(ii) = nanmean(hrc(:)); 
  
end

sl = sl/max(sl(:));
slm = slm/max(slm(:));
slc = slc/max(slc(:));

sr = sr/max(sr(:));
srm = srm/max(srm(:));
src = src/max(src(:));

% fit to kidney t2stars
disp(' ');
disp('overall t2star values');
[fitresultl, gof] = fit_exp_mp(t, sl);
[fitresultr, gof] = fit_exp_mp(t, sr);
% disp('overall t2star values');
fitresultl
fitresultr

% fit to medulla t2stars
disp(' ');
disp('medulla t2star values');
[fitresultlm, gof] = fit_exp_mp(t, slm);
[fitresultrm, gof] = fit_exp_mp(t, srm);

% disp('medulla t2star values');
fitresultlm
fitresultrm

% fit to cortex t2stars
disp(' ');
disp('cortex t2star values');
[fitresultlc, gof] = fit_exp_mp(t, slc);
[fitresultrc, gof] = fit_exp_mp(t, src);

fitresultlc
fitresultrc


% find the scan's completion time
% ct = str2num(readprocpar(image_path(1:end-5),'time_complete'));



