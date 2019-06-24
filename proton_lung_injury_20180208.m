% proton_lung_injury_20160218()
%
% originally named: GEMS_overlay_H_C_20140409_gems
%
% The file reads reconstructed fdf proton and all carbon images. It also
% averages images indexed from n1 to n2 and interpolates the averaged image
% to match it to the size of the proton image. 
%
% File Created by Mehrdad Pourfathi on 02/14/2014
% 
% Update #1 by Mehrdad Pourfathi on 02/17/2014:
% a. Calculated SNR as mean(FOV)/std(noisy region)
% b. Loops over the number of images averaged number to cplot SNR vs./
% number of images averaged.
%
% Update # 2 by Mehrdad Pourfathi on 2/21/2014
% Checks for multislice proton images and opens all of them. 
% 
% Update # 3 by Mehrdad Pourfathi on 3/3/2014
% a. checks for proton images.
% b. calcuates and plots the snr for individual images as well as the
% avareged images. 
% c. calcualtes th cumulative snr for the range of images defined. 
%
% Update # 4 by Mehrdad Pourfathi on 4/9/2014
% a. used interpolate_image function
% b. using getsn_click to find the range of ROIs for snr calculation. 
%
% Update % 5 by MP on 10/27/2015
% added the montage command.
%
% Update % 6 by MP on 02/18/2016
% file complete modified and renamed for the lung injury data analysis. 
%
% Update % 7 by MP on 09/12/2016
% Filenames are in a separate file.
%
% Update % 8 by MP on 02/06/2018
% when summing proton images to overlay the carbon scan, it looks at the
% signal thickness and choses how many images to sum
%
% Update % 8 by MP on 02/06/2018
% when summing proton images to overlay the carbon scan, it looks at the
% signal thickness and choses how many images to sum
%
% Update % 9 by MP on 02/08/2018
% reads data from the new datalist.

clear h h1;
multislice_proton = 1;

%% read proton images
proton_image_path = path(ll).proton_path;
nslice = path(ll).proton_slices;

%% Open proton images
jj = 0; % reset file counter
file_h = dir(proton_image_path);
for ii = 1:numel(file_h)
    if ~isempty(strfind(file_h(ii).name,'slice'))
        jj = jj + 1;  % if the file name included 'slice'
%         disp(file_h(ii).name)
        path1 = [proton_image_path file_h(ii).name];
        h(:,:,jj) = fdf2(path1);
        h1(:,:,1,jj) = h(:,:,jj);
    end
%     save_figure('proton',proton_image_path,1,1,0)
end
figure(123);
montage(uint16(h1));
caxis([0 max(h1(:))/2]);

% chose the proper slice depending on the dataset.
if ll <= 28
    proton = h(:,:,6);
elseif and(ll>=29,ll<=34)
    proton = h(12:117,12:117,5);
elseif and(ll>=35,ll<=37)
    proton = h(6:122,6:122,4);
elseif and(ll>=38,ll<=43)
    proton = h(6:122,6:122,4);  
elseif and(ll>=60,ll<=62)
    proton = h(37:224,37:224,6);
else
    if proton_sum_image
        thk_13c = readprocpar(path(ll).name,'thk'); thk_13c = thk_13c(2);
        if thk_13c == 15
            proton = sum(h(:,:,nslice-3:nslice+3),3);
        elseif thk_13c == 10
            proton = sum(h(:,:,nslice-2:nslice+2),3);
        end  
    else
        proton = h(:,:,nslice);
    end
    if and(ll>=63,ll <=65)
        proton = fliplr(proton);
    end
end


save_figure('proton_images',proton_image_path,1,1,0);
