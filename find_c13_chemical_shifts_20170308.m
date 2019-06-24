% find_c13_chemical_shifts_20170308()
%
% updated by MP on 3/8/2017: has to option to set the reference chemical
% shift to lactate

% read imaging parameters (bandwidth and center frequency)
sw = readprocpar(data_path,'sw'); sw = sw(2);
sfrq = readprocpar(data_path,'sfrq'); sfrq = sfrq(2);

% define chemical shifts
cs_pyr = 0;
cs_lac = 12.3;
cs_ala = 5.7;
cs_bic = -10.1;
cs_hyd = 8.3;

% find the index maximum peak (pyruvate)
[~,ref_index] = max(squeeze(sum(sum(abs(fnorm8(:,:,:,1,1)),1),2)));

% find ppm vector
n = 1:Nt;
sw_ppm = sw/sfrq;
delta_cs = sw_ppm/length(n);

% check the reference chemical shift
if lac_bigger_than_pyr
    ref_ppm = 183;
else
    ref_ppm = 171;
end
cs = (ref_index-n)*delta_cs+ref_ppm;


% find corresponding indices
% pyr_idx = intersect(find(cs<174),find(cs>167)); % pyruvate
% lac_idx = intersect(find(cs<184),find(cs>180)); % lactate
% ala_idx = intersect(find(cs<178),find(cs>175)); % alanine
% bic_idx = intersect(find(cs<162),find(cs>159)); % bicarbonate
% hyd_idx = intersect(find(cs<180),find(cs>178)); % hydrate

pyr_idx = intersect(find(cs<175),find(cs>166)); % pyruvate
lac_idx = intersect(find(cs<186),find(cs>181)); % lactate
ala_idx = intersect(find(cs<178),find(cs>175)); % alanine
bic_idx = intersect(find(cs<162),find(cs>159)); % bicarbonate
hyd_idx = intersect(find(cs<187),find(cs>183)); % hydrate