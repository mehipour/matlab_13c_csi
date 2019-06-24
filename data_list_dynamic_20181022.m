path = struct('name','','proton_path','','injection','','rat_number','','cohort','','weight','','proton_slice','','scan_date','');

main_folder = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/';
c13_seq_name = [];
h1_seq_name = [];
hupc_scan_number = [];

%% Rats
% rat201
path(1).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181024_rat201dyn/s_2018102401/axial_pd_rat_01.img/';
path(1).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181024_rat201dyn/s_2018102401/csi_13c_16x16_08';
path(1).proton_slices = 4;

% rat202
path(2).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181024_rat202dyn/s_2018102402/axial_pd_rat_01.img/';
path(2).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181024_rat202dyn/s_2018102402/csi_13c_16x16_04';
path(2).proton_slices = 4;


%% Phantom
% Phantom
path(1001).proton_path = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181022_dynamic_phantom/s_2018102201/localizer_rat_01.img/';
path(1001).name = '/Users/mehipour/Library/Mobile Documents/com~apple~CloudDocs/Data/HUP-C data/20181022_dynamic_phantom/s_2018102201/csi_13c_16x16_10';
path(1001).proton_slices = 7;


