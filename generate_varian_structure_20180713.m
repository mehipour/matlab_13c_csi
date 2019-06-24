% generate_varian_stucture_20180208
% create by MP on 2/8/2018
%
% puts together the information from the data_list file to create the
% carbon and proton filepath names as well as the structure to save the
% data
%
% update(1) by MP on 2/19/2018
% improves list management

% load default values
if isempty(c13_seq_name)
    c13_seq_name = 'csi_13c_16x16';
end
if isempty(h1_seq_name)
    h1_seq_name = 'axial_pd_rat';
end
if isempty(carbon_scan_numbers)
   carbon_scan_numbers = {'04','08','12','16'};
end
if isempty(proton_scan_numbers)
    proton_scan_numbers = {'01','03','06','09'};
end
if length(proton_scan_numbers)==4
    injections = {'1','2','3','4'};
end
if isempty(hupc_scan_number)
    hupc_scan_number = '01';
end
   

proton_data_folder = strcat(scan_date, '_rat', num2str(rat_number), cohort(1:end-2),'/s_', scan_date, hupc_scan_number, '/', h1_seq_name, '_');
carbon_data_folder = strcat(scan_date, '_rat', num2str(rat_number), cohort(1:end-2),'/s_', scan_date, hupc_scan_number, '/', c13_seq_name, '_');

for data_name_loop = 1:length(carbon_scan_numbers)
   path(n+data_name_loop-1).name = [main_folder, carbon_data_folder , cell2mat(carbon_scan_numbers(data_name_loop))]; 
   path(n+data_name_loop-1).proton_path = [main_folder, proton_data_folder , cell2mat(proton_scan_numbers(data_name_loop)),'.img/'];
   path(n+data_name_loop-1).injection = ['inj',cell2mat(injections(data_name_loop))];
   path(n+data_name_loop-1).weight = weight;
   path(n+data_name_loop-1).rat_number = rat_number;
   path(n+data_name_loop-1).cohort = cohort;
   path(n+data_name_loop-1).proton_slices = cell2mat(proton_slice(data_name_loop));
   path(n+data_name_loop-1).scan_date = scan_date;
   path(n+data_name_loop-1).spo2 = str2num(cell2mat(spo2(data_name_loop)));
end


