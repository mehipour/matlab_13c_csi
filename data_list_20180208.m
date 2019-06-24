path = struct('name','','proton_path','','injection','','rat_number','','cohort','','weight','','proton_slice','','scan_date','');

main_folder = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/';
c13_seq_name = [];
h1_seq_name = [];
hupc_scan_number = [];


% rat2hcl
path(1).name ='/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151015_rat02hcl/carbon data/inj1/2dCSIv1_05';
path(2).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151015_rat02hcl/carbon data/inj2/2dCSIv1_07';
% path(3).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151015_rat02hcl/carbon data/inj3/2dCSIv1_09';
path(3).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151015_rat02hcl/carbon data/inj4/2dCSIv1_11';

% rat5hcl
path(4).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151021_rat05hcl/processed data/inj1/2dCSIv1_02';
path(5).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151021_rat05hcl/processed data/inj2/2dCSIv1_04';
path(6).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151021_rat05hcl/processed data/inj3/2dCSIv1_06';

% rat6hcl
path(7).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151022_rat06hcl/inj1/2dCSIv1_02';
path(8).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151022_rat06hcl/inj2/2dCSIv1_04';
path(9).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151022_rat06hcl/inj3/2dCSIv1_06';
path(9).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151022_rat06hcl/inj4/2dCSIv1_08';

% rat7hcl
path(10).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151023_rat07hcl/inj1/2dCSIv1_02';
path(11).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151023_rat07hcl/inj2/2dCSIv1_04';
path(12).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151023_rat07hcl/inj3/2dCSIv1_06';
path(13).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151023_rat07hcl/inj4/2dCSIv1_08';

% rat8hcl
path(14).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151027_rat08saline/inj1/2dCSIv1_02';
path(15).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151027_rat08saline/inj2/2dCSIv1_05';
path(16).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151027_rat08saline/inj3/2dCSIv1_07';

% rat9hcl
path(17).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151029_rat09hcl/inj1/2dCSIv1_02';
path(18).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151029_rat09hcl/inj2/2dCSIv1_04';
path(19).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151029_rat09hcl/inj3/2dCSIv1_07';
path(20).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151029_rat09hcl/inj4/2dCSIv1_09';

% rat10hcl
path(21).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151030_rat10hcl/inj1/2dCSIv1_02';
path(22).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151030_rat10hcl/inj2/2dCSIv1_04';
path(23).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151030_rat10hcl/inj3/2dCSIv1_06';

% rat11hcl
path(24).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151105_rat11hcl/inj1/2dCSIv1_02';
path(25).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151105_rat11hcl/inj2/2dCSIv1_04';
path(26).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151105_rat11hcl/inj3/2dCSIv1_06';

% rat12hcl
path(27).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151106_rat12hcl/inj1/2dCSIv1_02';

% rat13hlc
path(28).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151106_rat13hcl/inj1/2dCSIv1_02';

% rat14hcl (protected)
path(29).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151112_rat14hcl/inj1/2dCSIv1_02';
path(30).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151112_rat14hcl/inj2/2dCSIv1_04';
path(31).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151112_rat14hcl/inj3/2dCSIv1_06';

% rat15hcl (hcl + protected + trpv4)
path(32).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151118_rat15hcl/inj1/2dCSIv1_03';
path(33).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151118_rat15hcl/inj2/2dCSIv1_05';
path(34).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151118_rat15hcl/inj3/2dCSIv1_07';

% rat16saline
path(35).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151119_rat16saline/inj1/2dCSIv1_03';
path(36).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151119_rat16saline/inj2/2dCSIv1_05';
path(37).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151119_rat16saline/inj3/2dCSIv1_07';

% rat17saline
path(38).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151123_rat17saline/inj1/2dCSIv1_02';
path(39).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151123_rat17saline/inj2/2dCSIv1_04';

% rat20hcl
path(40).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151202_rat20hcl/inj1/2dCSIv1_04';
path(41).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151202_rat20hcl/inj2/2dCSIv1_07';
path(42).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151202_rat20hcl/inj3/2dCSIv1_10';

% rat21hcl
path(43).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151203_rat21hcl/inj1/2dCSIv1_02';

% rat22hcl
path(44).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151209_rat22hcl/inj1/2dCSIv1_02';
path(45).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151209_rat22hcl/inj2/2dCSIv1_04';
path(46).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151209_rat22hcl/inj3/2dCSIv1_06';

% rat23hcl
path(47).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151210_rat23hcl/inj1/2dCSIv1_02';
path(48).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151210_rat23hcl/inj2/2dCSIv1_04';
path(49).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151210_rat23hcl/inj3/2dCSIv1_06';

% rat24hcl
path(50).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151214_rat24hcl/inj1/2dCSIv1_03';

% rat25hcl
path(51).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151214_rat25hcl/inj1/2dCSIv1_02';
path(52).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151214_rat25hcl/inj2/2dCSIv1_06';
path(53).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20151214_rat25hcl/inj3/2dCSIv1_08';

% rat26control
n = 54;
cohort = 'contrl';
rat_number = 26;
weight = 310;
scan_date = '20151215';
injections = {'1','2','3'};
carbon_scan_numbers = {'03','05','07'};
proton_scan_numbers = {'01','01','01'};
proton_slice = {9,9,9};
hupc_scan_number = '01';
c13_seq_name = '2dCSIv1';
h1_seq_name = 'gems';
spo2 = {'99','98','99'};
generate_varian_structure_20180713();


% rat28control
% path(60).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160127_rat28hcl/s_2016012701/csi2d_tab_C13_11';
path(60).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160128_rat29control/s_2016012802/csi2d_tab_C13_03';
path(61).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160128_rat29control/s_2016012802/csi2d_tab_C13_05';
path(62).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160128_rat29control/s_2016012802/csi2d_tab_C13_05';

% rat31control
n = 63;
cohort = 'contrl';
rat_number = 31;
weight = 290;
scan_date = '20160203';
injections = {'1','2','3'};
carbon_scan_numbers = {'05','10','14'};
proton_scan_numbers = {'01','03','01'};
proton_slice = {10,10,10};
hupc_scan_number = '03';
c13_seq_name = 'csi2d_tab_C13';
h1_seq_name = 'gems';
spo2 = {'99','99','97'};
generate_varian_structure_20180713();

% rat32control
n = 66;
cohort = 'contrl';
rat_number = 32;
weight = 290;
scan_date = '20160204';
injections = {'1','2','3'};
carbon_scan_numbers = {'05','08','11'};
proton_scan_numbers = {'01','02','03'};
proton_slice = {8,8,8};
hupc_scan_number = '02';
c13_seq_name = 'csi2d_tab_C13';
h1_seq_name = 'axial_pd_rat';
spo2 = {'99','99','98'};
generate_varian_structure_20180713();

% rat33control
n = 69;
cohort = 'contrl';
rat_number = 33;
weight = 300;
scan_date = '20160205';
injections = {'1','2','3'};
carbon_scan_numbers = {'05','08','14'};
proton_scan_numbers = {'01','02','03'};
proton_slice = {10,10,10};
hupc_scan_number = '01';
c13_seq_name = 'csi2d_tab_C13';
spo2 = {'99','99','98'};
generate_varian_structure_20180713();

% rat34control
n = 72;
cohort = 'contrl';
rat_number = 34;
weight = 310;
scan_date = '20160208';
injections = {'1','2','3'};
carbon_scan_numbers = {'03','06','08'};
proton_scan_numbers = {'01','02','03'};
proton_slice = {10,10,10};
hupc_scan_number = '01';
c13_seq_name = 'csi2d_tab_C13';
h1_seq_name = 'axial_pd_rat';
spo2 = {'99','97','99'};
generate_varian_structure_20180713();

% rat35hcl
path(75).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160210_rat35hcl/s_2016021001/csi_13c_16x16_03';
path(76).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160210_rat35hcl/s_2016021001/csi_13c_16x16_06';
path(77).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160210_rat35hcl/s_2016021001/csi_13c_16x16_12';
path(78).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160210_rat35hcl/s_2016021001/csi_13c_16x16_17';

% rat36hcl
path(79).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160212_rat36hcl/s_2016021201/csi_13c_16x16_03';
path(80).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160212_rat36hcl/s_2016021201/csi_13c_16x16_07';
path(81).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160212_rat36hcl/s_2016021201/csi_13c_16x16_10';
path(82).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160212_rat36hcl/s_2016021201/csi_13c_16x16_13';

% 
% % rat10_liver
% path(83).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160217_rat10_liver/s_2016021703/csi_13c_16x16_04';
% path(84).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160217_rat10_liver/s_2016021703/csi_13c_16x16_05';
% path(85).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160217_rat10_liver/s_2016021703/csi_13c_16x16_06';

% rat102_rat
path(83).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160303_rat102_radiation/inj1/csi_13c_16x16_03';

% rat102_rat
path(84).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160304_rat101_radiation/inj1/csi_13c_16x16_03';

% rat203_rat
path(85).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160309_rat103_radiation/inj1/csi_13c_16x16_03';

% rat204_rat
path(86).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160310_rat204_radiation/inj1/csi_13c_16x16_02';

% rat105_rad
path(87).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160315_rat105_radiation/inj1/csi_13c_16x16_03';

% rat108_rad
path(88).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160330_healthy_rat/inj1/csi_13c_16x16_03';

% bleorat001
path(89).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160415_bleorat001/inj1/csi_13c_16x16_03';

% bleorat002
path(90).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160415_bleorat002/inj2/csi_13c_16x16_02';

% rat306_rad
% path(89).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160408_rat306_mri/inj1/csi_13c_16x16_07';
path(91).name = '/Volumefs/Macintosh HD 1/Data/HUP-C data/20160408_rat307_mri/inj1/csi_13c_16x16_07';
% path(89).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160411_rat107/inj1/csi_13c_16x16_03';

path(92).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160420_transrat_003_mri/inj1/csi_13c_16x16_02';
path(93).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160421_bleorat01_day14/inj1/csi_13c_16x16_03';
path(94).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160421_bleorat02_day14/inj1/csi_13c_16x16_02';
path(95).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160426_rat05bleo_day14/inj1/csi_13c_16x16_02';
path(96).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160426_rat06bleo_day14/inj1/csi_13c_16x16_05';
path(97).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160429_bleorat01_day21/inj1/csi_13c_16x16_02';
path(98).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160429_bleorat02_day21/inj1/csi_13c_16x16_02';
path(99).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160531_transrat_003_mri_04/s_2016053102/csi_13c_16x16_03';
path(100).name = '/Volumes/MEHIPOUR I/s_2016061001/csi_13c_16x16_ph_02';
path(101).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160614_pH_healthy/s_2016061402/csi_13c_16x16_ph_03';
path(102).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160614_pH_healthy/s_2016061402/csi_13c_16x16_ph_07';

% transplant rat 2-image 1
path(103).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160616_transrat004_mri_01_day01/s_2016061601/csi_13c_16x16_02';

% healthy pH rat injections
% path(104).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160623_ph_mapping_healthy/s_2016062301/csi_13c_16x16_ph_05';
path(105).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160708_ph_mapping_injured/s_2016070801/csi_13c_16x16_ph_03';
% path(105).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160708_ph_mapping_injured/s_2016070801/csi_13c_16x16_ph_08';
% path(105).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160708_ph_mapping_injured/s_2016070801/csi_13c_16x16_ph_11';

% rat01_vili_kidney
path(106).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160701_rat1vili_kidney/s_2016070101/csi_13c_16x16_04';
path(107).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160701_rat1vili_kidney/s_2016070101/csi_13c_16x16_07';
path(108).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160701_rat1vili_kidney/s_2016070101/csi_13c_16x16_10';
path(106).injection = 1;
path(107).injection = 2;
path(108).injection = 4;

% rat02_vili_kidney
path(109).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160707_rat2vili_kidney/s_2016070702/csi_13c_16x16_04';
path(110).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160707_rat2vili_kidney/s_2016070702/csi_13c_16x16_08';
path(111).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160707_rat2vili_kidney/s_2016070702/csi_13c_16x16_12';
path(109).injection = 1;
path(110).injection = 2;
path(111).injection = 4;

% rat03_vili_kidney
path(112).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160712_rat3vili_kidney/s_2016071201/csi_13c_16x16_var_02';
path(113).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160712_rat3vili_kidney/s_2016071201/csi_13c_16x16_var_04';
path(114).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160712_rat3vili_kidney/s_2016071201/csi_13c_16x16_var_06';
path(112).injection = 1;
path(113).injection = 2;
path(114).injection = 4;

% rat04_hcl_kidney
path(115).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160719_rat4hcl_kidney/s_2016071901/csi_13c_16x16_var_02';
path(116).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160719_rat4hcl_kidney/s_2016071901/csi_13c_16x16_var_05';
path(115).injection = 1;
path(116).injection = 2;

% rat05_dose_kidney
path(117).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160719_rat05dose_kidney/s_2016071902/csi_13c_16x16_var_04';
path(118).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160719_rat05dose_kidney/s_2016071902/csi_13c_16x16_var_06';
path(119).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160719_rat05dose_kidney/s_2016071902/csi_13c_16x16_var_09';
path(117).injection = 1;
path(118).injection = 2;
path(119).injection = 4;

% rat06hcl_kidney
path(120).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160722_rat06hcl_kidney/s_2016072201/csi_13c_16x16_var_02';
path(121).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160722_rat06hcl_kidney/s_2016072201/csi_13c_16x16_var_09';
path(120).injection = 1;
path(121).injection = 2;

% rat40hcl
n = 122;
cohort = 'hclpe';
rat_number = 40;
weight = 380;
scan_date = '20160801';
proton_slice = {8,5,5};  
carbon_scan_numbers = {'02','05','08'};
proton_scan_numbers = {'01','05','07'};
injections = {'1','2','4'};
hupc_scan_number = '01';
c13_seq_name = 'csi_13c_16x16';
spo2 = {'99','91','92'};
generate_varian_structure_20180713();
h1_seq_name = [];


% rat41hcl
n = 125;
cohort = 'hclpe';
rat_number = 41;
weight = 420;
scan_date = '20160802';
proton_slice = {10,10,10};  
carbon_scan_numbers = {'02','05','09'};
proton_scan_numbers = {'01','04','05'};
injections = {'1','2','3'};
hupc_scan_number = '01';
c13_seq_name = 'csi_13c_16x16';
spo2 = {'99','97','85'};
generate_varian_structure_20180713();
h1_seq_name = [];


% rat42hcl
n = 128;
cohort = 'hclze';
rat_number = 42;
weight = 340;
scan_date = '20160803';
injections = {'1','2','4'};
carbon_scan_numbers = {'03','06','09'};
proton_scan_numbers = {'01','03','05'};
proton_slice = {8,8,8};
hupc_scan_number = '02';
spo2 = {'96','96','87'};
generate_varian_structure_20180713();

% transrat05_day07_mri01
path(131).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160803_transrat005_mri_01_day07/s_2016080301/csi_13c_16x16_04';

% transrat06_day04_mri01
path(132).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160808_transrat006_mri_01_day04/s_2016080801/csi_13c_16x16_04';

% rat109_radiation
path(133).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160810_rat109_radiation/s_2016081001/csi_13c_16x16_03';

% rat207_radiation
path(134).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160810_rat207_radiation/s_2016081002/csi_13c_16x16_05';

% rat108_radiation
path(135).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160810_rat108_radiation/s_2016081003/csi_13c_16x16_03';

% rat206_radiation
path(136).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160810_rat206_radiation/s_2016081004/csi_13c_16x16_07';

% transrat06_day08_mri02
path(137).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160812_transrat006_mri_02_day08/s_2016081201/csi_13c_16x16_03';

% rat43hcl
n = 138;
cohort = 'hclze';
rat_number = 43;
weight = 300;
scan_date = '20160812';
injections = {'1','2','4'};
carbon_scan_numbers = {'03','06','08'};
proton_scan_numbers = {'01','03','06'};
proton_slice = {9,9,9};
hupc_scan_number = '02';
spo2 = {'98','97','89'};
generate_varian_structure_20180713();

% transrat06_day21_mri03
path(141).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160825_transrat006_mri_03_day21/s_2016082501/csi_13c_16x16_03';

% transrat05_day29_mri02
path(142).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160825_transrat005_mri_02_day29/s_2016082502/csi_13c_16x16_04';

% transrat07_day03_mri01
path(143).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160826_transrat007_mri_01_day03/s_2016082601/csi_13c_16x16_03';

% rat44hcl
n = 144;
cohort = 'hclpe';
rat_number = 44;
weight = 340;
scan_date = '20160829';
proton_slice = {8,8,8};  
carbon_scan_numbers = {'03','07','10'};
proton_scan_numbers = {'01','03','08'};
injections = {'1','2','4'};
hupc_scan_number = '01';
c13_seq_name = 'csi_13c_16x16';
spo2 = {'95','96','89'};
generate_varian_structure_20180713();
h1_seq_name = [];

% transrat07_day07_mri02
path(147).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160830_transrat007_mri_02_day07/s_2016083001/csi_13c_16x16_03';

% rat45hcl
path(148).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160830_rat45hcl/s_2016083002/csi_13c_16x16_03';
path(149).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160830_rat45hcl/s_2016083002/csi_13c_16x16_06';
path(148).injection = 1;
path(149).injection = 2;

% rat46hcl_ph
path(150).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160831_rat46hcl_ph/s_2016083101/csi_13c_16x16_ph_03';
path(151).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160831_rat46hcl_ph/s_2016083101/csi_13c_16x16_ph_10';
path(150).injection = 1;
path(151).injection = 2;

% rat48hcl
n = 152;
cohort = 'hclze';
rat_number = 48;
weight = 360;
scan_date = '20160906';
injections = {'1','2','4'};
carbon_scan_numbers = {'05','09','14'};
proton_scan_numbers = {'01','02','09'};
proton_slice = {8,8,8};
hupc_scan_number = '01';
spo2 = {'97','98','85'};
generate_varian_structure_20180713();


% transrat07_day15_mri03
path(155).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160907_transrat007_mri_02_day15/s_2016090701/csi_13c_16x16_04';
path(156).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160907_transrat007_mri_02_day15/s_2016090701/csi_13c_16x16_ph_04';
path(155).injection = 1;
path(156).injection = 2;

% rat49hcl
n = 157;
cohort = 'hclze';
rat_number = 49;
weight = 300;
scan_date = '20160908';
injections = {'1','2','3'};
carbon_scan_numbers = {'03','07','10'};
proton_scan_numbers = {'01','04','07'};
proton_slice = {10,10,10};
hupc_scan_number = '01';
spo2 = {'98','96','91'};
generate_varian_structure_20180713();

% rat50hcl
path(160).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160921_rat50hcl/s_2016092101/csi_13c_16x16_02';
path(161).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160921_rat50hcl/s_2016092101/csi_13c_16x16_05';
path(160).injection = 1;
path(161).injection = 2;

% rat51hcl
path(162).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160923_rat51hcl/s_2016092301/csi_13c_16x16_02';
path(163).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160923_rat51hcl/s_2016092301/csi_13c_16x16_04';
path(162).injection = 1;
path(163).injection = 2;

% rat52hcl
path(164).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160927_rat52hcl/s_2016092701/csi_13c_16x16_05';
path(165).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160927_rat52hcl/s_2016092701/csi_13c_16x16_07';
path(164).injection = 1;
path(165).injection = 2;

% rat53hcl
n = 166;
cohort = 'hclze';
rat_number = 53;
weight = 310;
scan_date = '20160929';
injections = {'1','2','3'};
carbon_scan_numbers = {'03','06','09'};
proton_scan_numbers = {'01','04','07'};
proton_slice = {8,8,8};
hupc_scan_number = '01';
spo2 = {'99','99','92'};
generate_varian_structure_20180713();


% rat401_radiation1
path(169).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160930_rat401_radiation/s_2016093001/csi_13c_16x16_05';

% rat402_radiation1
path(170).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160930_rat402_radiation/s_2016093002/csi_13c_16x16_04';
path(171).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20160930_rat402_radiation/s_2016093002/csi_13c_16x16_ph_03';

% rat401_radiation2
path(172).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161003_rat401_radiation/s_2016100302/csi_13c_16x16_02';

% rat402_radiation2
path(173).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161003_rat402_radiation/s_2016100301/csi_13c_16x16_02';

% rat_control1
path(174).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161004_ratcontrol1/s_2016100401/csi_13c_16x16_02';
% rat_control2
path(175).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161004_ratcontrol2/s_2016100402/csi_13c_16x16_03';

% rat54hcl
n = 176;
cohort = 'hclze';
rat_number = 54;
weight = 305;
scan_date = '20161005';
injections = {'1','2','3'};
carbon_scan_numbers = {'03','07','09'};
proton_scan_numbers = {'01','03','09'};
proton_slice = {8,8,6};
hupc_scan_number = '01';
spo2 = {'99','96','90'};
generate_varian_structure_20180713();

% rat55hcl
n = 179;
cohort = 'hclze';
rat_number = 55;
weight = 300;
scan_date = '20161117';
injections = {'1','2','3'};
carbon_scan_numbers = {'04','07','10','13'};
proton_scan_numbers = {'01','04','07','11'};
proton_slice = {10,10,10,10};
hupc_scan_number = '01';
spo2 = {'98','97','93','98'};
generate_varian_structure_20180713();

% rat56hcl
path(183).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161118_rat56hcl/s_2016111801/csi_13c_16x16_05';
path(184).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161118_rat56hcl/s_2016111801/csi_13c_16x16_08';
path(183).injection = 1;
path(184).injection = 2;

% rat57hcl (zeep)
n = 185;
cohort = 'hclze';
rat_number = 57;
weight = 320;
scan_date = '20161205';
proton_slice = {10,9,9,9};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'03','06','09','11'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'98','97','95','86'};
generate_varian_structure_20180713();
h1_seq_name = [];

%rat58hcl
n = 189;
cohort = 'hclpe';
rat_number = 58;
weight = 312;
scan_date = '20161207';
proton_slice = {9,10,10,10};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
c13_seq_name = 'csi_13c_16x16';
spo2 = {'98','97','96','95'};
generate_varian_structure_20180713();
h1_seq_name = [];

%rat59hcl
path(193).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161212_rat59hcl/s_2016121201/csi_13c_16x16_04';
path(194).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161212_rat59hcl/s_2016121201/csi_13c_16x16_08';
path(193).injection = 1;
path(194).injection = 2;

%rat60hcl
path(195).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161214_rat60hcl/s_2016121401/csi_13c_16x16_04';
path(195).injection = 1;

% rat61hcl (peep)
n = 196;
cohort = 'hclpe';
rat_number = 61;
weight = 312;
scan_date = '20161215';
proton_slice = {10,10,10,11};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
c13_seq_name = 'csi_13c_16x16';
spo2 = {'96','96','95','95'};
generate_varian_structure_20180713();
h1_seq_name = [];

%rat62hcl
n = 200;
cohort = 'hclpe';
rat_number = 62;
weight = 320;
scan_date = '20161216';
proton_slice = {7,11,11,12};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
c13_seq_name = 'csi_13c_16x16';
spo2 = {'98','98','98','97'};
generate_varian_structure_20180713();
h1_seq_name = [];


%rat63hcl (207 is bad)
n = 204;
cohort = 'hclpe';
rat_number = 63;
weight = 320;
scan_date = '20170111';
proton_slice = {9,9,9,9};  
carbon_scan_numbers = {'04','08','12'};
proton_scan_numbers = {'01','04','06'};
injections = {'1','2','3'};
hupc_scan_number = '01';
c13_seq_name = 'csi_13c_16x16';
spo2 = {'92','93','88'};
generate_varian_structure_20180713();
h1_seq_name = [];


%rat64hcl
n = 208;
cohort = 'hclpe';
rat_number = 64;
weight = 287;
scan_date = '20170118';
proton_slice = {9,12,12,12};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
c13_seq_name = 'csi_13c_16x16';
spo2 = {'99','97','97','98'};
generate_varian_structure_20180713();
h1_seq_name = [];


%rat65hcl (saline)
path(212).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170126_rat65hcl/s_2017012601/csi_13c_16x16_04';
path(213).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170126_rat65hcl/s_2017012601/csi_13c_16x16_08';
path(214).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170126_rat65hcl/s_2017012601/csi_13c_16x16_12';
path(215).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170126_rat65hcl/s_2017012601/csi_13c_16x16_16';
path(212).injection = 1;
path(213).injection = 2;
path(214).injection = 3;
path(215).injection = 4;

%rat66hcl (saline)
path(216).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170131_rat66hcl/s_2017013102/csi_13c_16x16_04';
path(217).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170131_rat66hcl/s_2017013102/csi_13c_16x16_08';
path(218).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170131_rat66hcl/s_2017013102/csi_13c_16x16_12';
path(216).injection = 1;
path(217).injection = 2;
path(218).injection = 3;

%rat67hcl (saline)
path(219).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170201_rat67hcl/s_2017020101/csi_13c_16x16_04';
path(219).injection = 1;

%rat68hcl (saline)
n = 220;
cohort = 'hclsh';
rat_number = 68;
weight = 305;
scan_date = '20170207';
proton_slice = {10,10,10,10};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '02';
h1_seq_name = [];
c13_seq_name = [];
spo2 = {'99','99','99','99'};
generate_varian_structure_20180713();

%rat69hcl (saline)
n = 224;
cohort = 'hclsh';
rat_number = 69;
weight = 300;
scan_date = '20170216';
proton_slice = {7,8,8,8};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
h1_seq_name = [];
c13_seq_name = [];
spo2 = {'99','99','99','99'};
generate_varian_structure_20180713();

%rat70hcl (saline)
n = 228;
cohort = 'hclsh';
rat_number = 70;
weight = 320;
scan_date = '20170223';
proton_slice = {6,9,9,9};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
h1_seq_name = [];
c13_seq_name = [];
spo2 = {'99','99','99','99'};
generate_varian_structure_20180713();

% %rat71hcl (saline)
n = 232;
cohort = 'hclsh';
rat_number = 71;
weight = 284;
scan_date = '20170227';
proton_slice = {8,6,6,6};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99','99','99','99'};
generate_varian_structure_20180713();
h1_seq_name = [];

%rat72hcl (saline)
n = 236;
cohort = 'hclsh';
rat_number = 72;
weight = 298;
scan_date = '20170307';
proton_slice = {9,10,10,10};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99','97','98','97'};
generate_varian_structure_20180713();
h1_seq_name = [];

%rat73hcl (saline)
n = 240;
cohort = 'hclsh';
rat_number = 73;
weight = 303;
scan_date = '20170309';
proton_slice = {9,9,9,9};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99','99','99','99'};
generate_varian_structure_20180713();
h1_seq_name = [];

%rat74hcl (hcl-prone-zeep)
n = 244;
cohort = 'hclze';
rat_number = 74;
weight = 323;
scan_date = '20170316';
proton_slice = {9,9,9,9};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','08'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99','99','99','95'};
generate_varian_structure_20180713();
h1_seq_name = [];

%rat75hcl (hcl-prone)
path(248).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170320_rat75hcl/s_2017032001/csi_13c_16x16_04';
path(249).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170320_rat75hcl/s_2017032001/csi_13c_16x16_08';
path(248).injection = 1;
path(249).injection = 2;

%rat76hcl (injured-peep)
n = 250;
cohort = 'hclpe';
rat_number = 76;
weight = 287;
scan_date = '20170626';
proton_slice = {10,10,10,10};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','05','07','11'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'98','98','95','99'};
generate_varian_structure_20180713();
h1_seq_name = [];

%rat77hcl (injured-peep)
n = 254;
cohort = 'hclpe';
rat_number = 77;
weight = 306;
scan_date = '20170627';
proton_slice = {9,5,5,8};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','05','08','12'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99','99','99','99'};
generate_varian_structure_20180713();
h1_seq_name = [];


% rat78hcl (injured-peep)
n = 258;
cohort = 'hclpe';
rat_number = 78;
weight = 314;
scan_date = '20170705';
proton_slice = {12,8,8,8};  
carbon_scan_numbers = {'04','08','12','15'};
proton_scan_numbers = {'01','04','06','09'};
% proton_scan_numbers = {'01','04','06','11'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99','99','99','99'};
generate_varian_structure_20180713();
h1_seq_name = [];

% rat79hcl (sham-zeep)
n = 262;
cohort = 'hclsh';
rat_number = 79;
weight = 305;
scan_date = '20170706';
proton_slice = {10,9,9,9};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','12'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'98','98','98','98'};
generate_varian_structure_20180713();
h1_seq_name = [];

%% Hypoxia Studies
% rat80hyp (hypoxia-90%)
n = 266;
cohort = 'hyp90';
rat_number = 80;
weight = 303;
scan_date = '20171205';
proton_slice = {8,8};
carbon_scan_numbers = {'04','07'};
proton_scan_numbers = {'02','04'};
injections = {'1','2'};
spo2 = {'98','92.1'};
generate_varian_structure_20180713();

% rat81hyp (hypoxia-90%)
n = 268;
cohort = 'hyp90';
rat_number = 81;
weight = 301;
scan_date = '20171206';
proton_slice = {6,5};
carbon_scan_numbers = {'04','08'};
proton_scan_numbers = {'01','03'};
injections = {'1','2'};
spo2 = {'99.4','87.9'};

generate_varian_structure_20180713();

% rat82hyp (hypoxia-90%)
n = 270;
cohort = 'hyp90';
rat_number = 82;
weight = 324;
scan_date = '20171208';
proton_slice = {7,7,7};
hupc_scan_number = '01';
carbon_scan_numbers = {'04','08','15'};
proton_scan_numbers = {'01','03','09'};
injections = {'1','2','4'};
spo2 = {'99.2','86','89.6'};
generate_varian_structure_20180713();

% rat83hyp (hypoxia-90%)
n = 273;
cohort = 'hyp90';
rat_number = 83;
weight = 315;
scan_date = '20171212';
proton_slice = {6,6,6,6};
carbon_scan_numbers = {'05','09','13','17'};
proton_scan_numbers = {'01','03','06','08'};
spo2 = {'99.2','90.4','91.4','90.3'};
generate_varian_structure_20180713();

% rat84hyp (hypoxia-90%)
n = 277;
cohort = 'hyp90';
rat_number = 84;
weight = 330;
scan_date = '20171215';
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','08'};
proton_slice = {8,8,8,8};
spo2 = {'99.2','90.4','91.7','90.3'};
generate_varian_structure_20180713();

% rat85hyp (hypoxia-90%)
n = 281;
cohort = 'hyp90';
rat_number = 85;
weight = 355;
scan_date = '20180117';
proton_slice = {8,8,8,8};
spo2 = {'97.7','90.4','91.7','89.8'};
generate_varian_structure_20180713();

% rat86hyp (hypoxia-90%)
n = 285;
cohort = 'hyp90';
rat_number = 86;
weight = 395;
scan_date = '20180119';
proton_slice = {7,7,7,7};
carbon_scan_numbers = {'03','08','11','15'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
spo2 = {'99.3','90.2','91.7','90.2'};
generate_varian_structure_20180713();

% rat87hyp (hypoxia-75%)
n = 289;
cohort = 'hyp75';
rat_number = 87;
weight = 292;
scan_date = '20180123';
proton_slice = {8,8,8};
carbon_scan_numbers = {'04','08','12'};
proton_scan_numbers = {'01','03','06'};
injections = {'1','2','3'};
spo2 = {'99.3','73.9','76'};
generate_varian_structure_20180713();

% rat88hyp (hypoxia-75%)
n = 292;
cohort = 'hyp75';
rat_number = 88;
weight = 300;
scan_date = '20180124';
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','04','06','09'};
proton_slice = {10,10,7,7};
spo2 = {'99.3','82.3','73.9','77.8'};
generate_varian_structure_20180713();

% rat89hyp (hypoxia-75%)
n = 296;
cohort = 'hyp75';
rat_number = 89;
weight = 302;
scan_date = '20180126';
proton_slice = {8,8,8,8};
spo2 = {'99.2','76.5','75.3','71'};
generate_varian_structure_20180713();

% rat90hyp (hypoxia-75%)
n = 300;
cohort = 'hyp75';
rat_number = 90;
weight = 280;
scan_date = '20180202';
proton_slice = {9,9,9,9};
spo2 = {'99.4','76.7','75.6','73'};
generate_varian_structure_20180713();

% rat91hyp (hypoxia-75%)
n = 304;
cohort = 'hyp75';
rat_number = 91;
weight = 275;
scan_date = '20180206';
proton_slice = {9,9,9,9};
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
spo2 = {'99.5','88.3','91.1','73.3'};
generate_varian_structure_20180713();

% rat93hyp (hypoxia-75%)
n = 308;
cohort = 'hyp75';
rat_number = 93;
weight = 274;
scan_date = '20180214';
proton_slice = {9,9,9}; 
carbon_scan_numbers = {'04','08','12'};
proton_scan_numbers = {'01','03','06'};
injections = {'1','2','3'};
spo2 = {'99.7','80.1','78.7'};
generate_varian_structure_20180713();

% rat94hyp (hypoxia-75%)
n = 311;
cohort = 'hyp75';
rat_number = 94;
weight = 281;
scan_date = '20180216';
proton_slice = {11,11,11}; 
carbon_scan_numbers = {'04','08','12'};
proton_scan_numbers = {'01','03','06'};
injections = {'1','2','3'};
spo2 = {'99.7','73','63.5'};
generate_varian_structure_20180713();

% rat95hyp (hypoxia-90%)
n = 314;
cohort = 'hyp90';
rat_number = 95;
weight = 307;
scan_date = '20180221';
proton_slice = {10,10,10,10}; 
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '02';
spo2 = {'99.6','92.7','90','93.1'};
generate_varian_structure_20180713();

% rat96hyp (hypoxia-90%)
n = 318;
cohort = 'hyp90';
rat_number = 96;
weight = 321;
scan_date = '20180309';
proton_slice = {7,7,7,7}; 
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99.2','89.1','89.4','70.2'};
generate_varian_structure_20180713();

% rat97sick (control/sick)
n = 322;
cohort = 'sickss';
rat_number = 97;
weight = 318;
scan_date = '20180313';
% proton_slice = {9,9,9,9}; 
proton_slice = {7,7,7,7}; 
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
% h1_seq_name = 'fse_short_te';
% h1_seq_name = 'coronal_gre'
% h1_seq_name = 'axial_ssfp_fid';
spo2 = {'99.8','98.8','98.7','93.5'};
generate_varian_structure_20180713();
h1_seq_name = [];


% rat98hyp (control)
n = 326;
cohort = 'contrl';
rat_number = 98;
weight = 322;
scan_date = '20180320';
proton_slice = {10,10,10,10}; 
% proton_slice = {7,7,7,7}; 
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99.1','99.3','99.2','99.1'};
generate_varian_structure_20180713();
h1_seq_name = [];


% rat99hyp (control)
n = 330;
cohort = 'contrl';
rat_number = 99;
weight = 250;
scan_date = '20180502';
proton_slice = {8,8,8,8};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99.1','99.3','99.7','99.7'};
generate_varian_structure_20180713();
h1_seq_name = [];

% rat100hyp (control)
n = 334;
cohort = 'contrl';
rat_number = 100;
weight = 250;
scan_date = '20180503';
proton_slice = {10,10,10,10};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99.7','99.6','99.6','99.6'};
generate_varian_structure_20180713();
h1_seq_name = [];

% rat101hyp (control)
n = 338;
cohort = 'contrl';
rat_number = 101;
weight = 275;
scan_date = '20180507';
proton_slice = {8,8,8,8};  
carbon_scan_numbers = {'04','08','12','16'};
proton_scan_numbers = {'01','03','06','09'};
injections = {'1','2','3','4'};
hupc_scan_number = '01';
spo2 = {'99.6','99.5','99.5','99.5'};
generate_varian_structure_20180713();
h1_seq_name = [];

% rat102hyp (control)
n = 342;
cohort = 'contrl';
rat_number = 102;
weight = 251;
scan_date = '20180508';
proton_slice = {6,6};  
carbon_scan_numbers = {'04','12'};
proton_scan_numbers = {'01','06'};
injections = {'1','3'};
hupc_scan_number = '01';
spo2 = {'99.4','99.1','99.3','99.2'};
generate_varian_structure_20180713();
h1_seq_name = [];

% % Diane's CIH mouse, cancer
% path(6006).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170308_cih_ih1-f02-2-228/s_2017030802/fse_t2_mouse_01.img/';
% path(6006).proton_slices = 7;
% path(6006).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20170308_cih_ih1-f02-2-228/s_2017030802/csi_13c_16x16_var_mouse_09';
% c13_seq_name = 'csi_13c_16x16_var_mouse';

%% Transplant Rats
% rat30-day30
path(1000).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180627_txrat30_day30/s_2018062701/axial_pd_rat_01.img/';
% path(1000).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180627_txrat30_day30/s_2018062701/fse_t2_01.img/';
path(1000).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180627_txrat30_day30/s_2018062701/csi_13c_16x16_04';
path(1000).proton_slices = 6;


% rat28-day30
path(1001).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180627_txrat28_day30/s_2018062702/axial_pd_rat_01.img/';
% path(1001).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180627_txrat28_day30/s_2018062702/fse_t2_01.img/';
path(1001).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180627_txrat28_day30/s_2018062702/csi_13c_16x16_05';
path(1001).proton_slices = 5;



%% Cancer Rats
% rat1
path(2000).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180926_cancer_rat1/s_2018092601/fse_t2_02.img/';
path(2000).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180926_cancer_rat1/s_2018092601/csi_13c_16x16_02';
path(2000).proton_slices = 6;

% rat2
path(2001).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180926_cancer_rat2/s_2018092602/fse_t2_cancer_axial_01.img/';
path(2001).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180926_cancer_rat2/s_2018092602/csi_13c_16x16_03';
path(2001).proton_slices = 6;

% rat3
path(2002).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180926_cancer_rat3/s_2018092603/fse_t2_cancer_axial_01.img/';
path(2002).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180926_cancer_rat3/s_2018092603/csi_13c_16x16_03';
path(2002).proton_slices = 6;


% rat49
path(2003).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180927_cancer_rat49/s_2018092701/axial_pd_rat_01.img/';
path(2003).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20180927_cancer_rat49/s_2018092701/csi_13c_16x16_02';
path(2003).proton_slices = 8;


% rat19
path(2004).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181004_cancer_rat19/s_2018100401/fse_t2_cancer_axial_02.img/';
path(2004).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181004_cancer_rat19/s_2018100401/csi_13c_16x16_04';
path(2004).proton_slices = 6;

%% Flow suppression rats

% rat ra204-\w flow suppression
path(3001).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161201_ra204control/s_2016120102/axial_pd_rat_01.img/';  
path(3001).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161201_ra204control/s_2016120102/csi_13c_16x16_05';  
path(3001).proton_slices = 9;
% rat ra204-\w flow suppression
path(3002).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161201_ra204control/s_2016120102/axial_pd_rat_01.img/';  
path(3002).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161201_ra204control/s_2016120102/csi_13c_16x16_31';  
path(3002).proton_slices = 9;


% rat ra203-\wo flow suppression
path(3003).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161201_ra203control/s_2016120101/axial_pd_rat_01.img/';  
path(3003).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161201_ra203control/s_2016120101/csi_13c_16x16_15';  
path(3003).proton_slices = 8;
% rat ra203-\w flow suppression
path(3004).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161201_ra203control/s_2016120101/axial_pd_rat_01.img/';  
path(3004).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20161201_ra203control/s_2016120101/csi_13c_16x16_35';  
path(3004).proton_slices = 8;


%% Elastase Induced Rats

% rat10ela
path(4001).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181121_Rat10ela/s_2018112101/axial_pd_rat_01.img/';  
path(4001).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181121_Rat10ela/s_2018112101/csi_13c_16x16_04';  
path(4001).proton_slices = 7;

% rat11ela
path(4002).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181121_Rat11ela/s_2018112102/axial_pd_rat_01.img/';  
path(4002).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181121_Rat11ela/s_2018112102/csi_13c_16x16_04';  
path(4002).proton_slices = 9;

