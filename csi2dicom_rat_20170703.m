%% convert to dicom files
%
% csi2dicom_rat_date()
%
% file created by Mehrdad Pourfathi on 9/02/15
% updated for rat02hcl on 10/15/16
% store carbon image
%
% Updated (2) by MP on 4/30/2016:
% variable with the animal number, injection number and basic imaging
% parameters in the beginning for different datasets. 
%
% Updated (3) by MP on 7/02/2016:
% added alanine, bicarbonate and their ratio maps to pyruvate.
%
% Updated (4) by MP on 8/13/2016:
% added a manual correction factor for the lactate maps in case an artifact
% occurs.
%
% Updated (5) by SMS on 11/10/2016:
% Saves dicom images in the data folder.
%
% Updated (6) by MP on 3/3/2017
% Can be called from the main processing function and updated folder
% management. Also replaced thresholding with the mask generated in the
% main function from the pyruvate image. Finally, all maps are normalized
% to their own maximum value obtained from their "masked" version.

% Is this csi data acquried with varian and processed with steve's code?
varian_lung_injury = 1;
siemens = 0;

% which ratio maps to be generated
% make_lac2pyr = 0;
make_ala2pyr = 0;
make_bic2pyr = 0;

% take this out with masking
correction_lac = 1;   % correction factor lactate images if artifact occured\
correction_pyr = 1;

Nshiftx = 0;
Nshifty = 0;

% find patient ID and scan number 
temp = strfind(data_path,'/');
injection_id = data_path(end-1:end);
animal_id = data_path(temp(end-2)+10:temp(end-1)-1);

% interpolation factor
int_fact = Ni_maps;

% manage image size and FOVs. 
C13_FOV_x = x_c13;
C13_FOV_y = y_c13;
C13_matrix_x = Nx*int_fact;
C13_matrix_y = Ny*int_fact;
H1_FOV_x = x_h1;
H1_FOV_y = y_h1;
H1_matrix_x = Nx_h1;
H1_matrix_y = Ny_h1;

% added this to save it to data's root directory -sms 11-10-16
if ~exist([data_path(1:temp(end-1)) 'dicom_maps/'],'dir')
    mkdir(data_path(1:temp(end-1)),'dicom_maps')
end
dicom_folder  = [data_path(1:temp(end-1)) 'dicom_maps/'];


%% carbon image
metadata.PatientName.FamilyName = animal_id;
metadata.PatientID = animal_id;
metadata.MRAcquisitionType = '2D';
metadata.SliceThickness = 15;
metadata.FlipAngle = 12;
metadata.PixelSpacing = [C13_FOV_x/C13_matrix_x C13_FOV_y/C13_matrix_y]';
metadata.LargestImagePixelValue = 1;
metadata.ImageOrientationPatient = [1 0 0  0 1 0]';
metadata.ImagePositionPatient = [0 0 0];
metadata.SliceLocation = 0;
metadata.PatientPosition = 'HFP';
metadata.AcquisitionMatrix = [C13_matrix_x 0 0 C13_matrix_y]';
metadata.Rows = C13_matrix_y;
metadata.Columns = C13_matrix_x;   
metadata.SamplesPerPixel = 1;

% which scanner generateedthe imge?
if varian_lung_injury
    pyr = interpolate_image(pyr_img,int_fact);
    bic = interpolate_image(bic_img,int_fact);
    ala = interpolate_image(ala_img,int_fact);
    lac = interpolate_image(lac_img,int_fact);
end
   
% created interpolated mask
% mask_interpolated = interpolate_image(mask,2);
mask_interpolated = mask;

% generate mets mask if metabolites are to be masekd too
if mask_met_images
    mask_met = mask;
else
    mask_met = ones(size(pyr));
end

if normalize_dicom_images
    lac_img_th1 = lac.*mask_met / max(max(mask_interpolated.*lac));
else
    lac_img_th1 = lac.*mask_met;
end
lac_img_th1 = int32(circshift(circshift(lac_img_th1,Nshifty,1),Nshiftx,2)*100*correction_lac);
filename = strcat(dicom_folder,'lac_',animal_id,'_',injection_id,'.dcm');
dicomwrite(lac_img_th1, filename,metadata,'ObjectType','MR Image Storage');

if normalize_dicom_images
    pyr_img_th1 = pyr.*mask_met / max(max(mask_interpolated.*pyr));
else
    pyr_img_th1 = pyr.*mask_met;
end
pyr_img_th1 = int32(circshift(circshift(pyr_img_th1,Nshifty,1),Nshiftx,2)*100*correction_pyr);
filename = strcat(dicom_folder,'pyr_',animal_id,'_',injection_id,'.dcm');
dicomwrite(pyr_img_th1, filename,metadata,'ObjectType','MR Image Storage');

if normalize_dicom_images
    ala_img_th1 = ala.*mask_met / max(max(mask_interpolated.*ala));
else
   ala_img_th1 = ala.*mask_met;
end
ala_img_th1 = int32(circshift(circshift(ala_img_th1,Nshifty,1),Nshiftx,2)*100);
filename = strcat(dicom_folder,'ala_',animal_id,'_',injection_id,'.dcm');
dicomwrite(ala_img_th1, filename,metadata,'ObjectType','MR Image Storage');

if normalize_dicom_images
    bic_img_th1 = bic.*mask_met / max(max(mask_interpolated.*bic));
else
    bic_img_th1 = bic.*mask_met;
end
bic_img_th1 = int32(circshift(circshift(bic_img_th1,Nshifty,1),Nshiftx,2)*100);
filename = strcat(dicom_folder,'bic_',animal_id,'_',injection_id,'.dcm');
dicomwrite(bic_img_th1, filename,metadata,'ObjectType','MR Image Storage');

if make_lac2pyr
    lac = lac.*mask;
    pyr = pyr.*mask;
    lac2pyr_img_th1 = lac./pyr;
    lac2pyr_img_th1 = int32(circshift(circshift(lac2pyr_img_th1,Nshifty,1),Nshiftx,2)*10000);
    filename = strcat(dicom_folder,'lac2pyr_',animal_id,'_',injection_id,'.dcm');
    dicomwrite(lac2pyr_img_th1, filename,metadata,'ObjectType','MR Image Storage');
end

if make_ala2pyr
    ala = ala.*mask;
    pyr = pyr.*mask;
    ala2pyr_img_th1 = ala./pyr;
    ala2pyr_img_th1 = int32(circshift(circshift(ala2pyr_img_th1,Nshifty,1),Nshiftx,2)*10000);
    filename = strcat(dicom_folder,'ala2pyr_',animal_number,'_inj',num2str(injection_number),'.dcm');
    dicomwrite(ala2pyr_img_th1, filename,metadata,'ObjectType','MR Image Storage');
end

if make_bic2pyr
    bic = threshold_image(bic,0.001);
    pyr = threshold_image(pyr,0.001);
    bic2pyr_img_th1 = bic./pyr;
    bic2pyr_img_th1 = int32(circshift(circshift(bic2pyr_img_th1,Nshifty,1),Nshiftx,2)*10000);
    filename = strcat(dicom_folder,'bic2pyr_',animal_number,'_inj',num2str(injection_number),'.dcm');
    dicomwrite(bic2pyr_img_th1, filename,metadata,'ObjectType','MR Image Storage');
end

%% store proton image
% metadata.PatientName.FamilyName = 'rat203';
% metadata.PatientID = 'rat203';
metadata.MRAcquisitionType = '2D';
metadata.SliceThickness = 2;
metadata.FlipAngle = 20;
metadata.PixelSpacing = [H1_FOV_x/H1_matrix_x H1_FOV_y/H1_matrix_y]';
metadata.LargestImagePixelValue = 1;
metadata.ImageOrientationPatient = [1 0 0  0 1 0]';
metadata.ImagePositionPatient = [0 0 0];
metadata.SliceLocation = 0;
metadata.PatientPosition = 'HFP';
metadata.AcquisitionMatrix = [H1_matrix_x 0 0 H1_matrix_y]';
metadata.Rows = H1_matrix_y;
metadata.Columns = H1_matrix_x;   
metadata.SamplesPerPixel = 1;

filename = strcat(dicom_folder,'proton_',animal_id,'_',injection_id,'.dcm');

if siemens
    dicomwrite(im2double(proton), filename,metadata,'ObjectType','MR Image Storage');
else
    dicomwrite(int32(proton/max(proton(:))*100), filename,metadata,'ObjectType','MR Image Storage');
end