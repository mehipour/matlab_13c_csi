% Combines all quantification in one CSV file
% 
% coded by MP on 2/5/2018
%
% modified by MP on 2/8/2018 for varian


% hypoxia;
csv_path = '/Users/mehipour/Documents/UPENN/Upenn Work/fMRI Lab/Projects/Hypoxia-Carbon-13/Data Analysis/R Analysis/Summary Data/';
summary_csv_file = strcat(csv_path,'R_lung_hypoxia_segmented_data_',date,'.csv');

if ~exist(summary_csv_file,'file') 
    % create file
    fid = fopen(summary_csv_file,'w');
        fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
     'rat', 'weight', 'cohort', 'injection', 'region', ...
     'lac', 'lac_std', 'pyr', 'pyr_std','ala','ala_std','bic','bic_std');
    fclose(fid);
else
    % go through regions
    for region_loop = 1:length(regions)
        % append to the file
        fid = fopen(summary_csv_file,'a');
        fprintf(fid,'%1.0f, %1.0f, %s, %s, %s, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f, %4.4f \n',...
            path(ll).rat_number, path(ll).weight, path(ll).cohort, ...
            path(ll).injection, cell2mat(regions(region_loop)), ...
            quantify_mask(region_loop).mets(2).mean, quantify_mask(region_loop).mets(2).std, ...
            quantify_mask(region_loop).mets(1).mean, quantify_mask(region_loop).mets(1).std, ...
            quantify_mask(region_loop).mets(3).mean, quantify_mask(region_loop).mets(3).std, ...
            quantify_mask(region_loop).mets(4).mean, quantify_mask(region_loop).mets(4).std);
        fclose(fid); 
    end
end




