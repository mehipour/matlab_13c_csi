% find_xe129_chemical_shifts()

%% note that in this code, pyr is gas phase, lac is the tissue phase and 
% ala is the RBC phase. bic and hyd are going to be just noise. 


% read imaging parameters (bandwidth and center frequency)
sw = readprocpar(data_path,'sw'); sw = sw(2);
sfrq = readprocpar(data_path,'sfrq'); sfrq = sfrq(2);

% define chemical shifts
cs_pyr = 0;
cs_lac = 197;
cs_ala = 218;
cs_bic = 100;
cs_hyd = 300;

% find the index maximum peak (pyruvate)
[~,ref_index] = max(squeeze(sum(sum(abs(fnorm8),1),2)));

% find ppm vector
n = 1:Nt;
sw_ppm = sw/sfrq;
delta_cs = sw_ppm/length(n);
ref_ppm = 0;
cs = (ref_index-n)*delta_cs+ref_ppm;

% find corresponding indices
pyr_idx = intersect(find(cs<60),find(cs>-40)); % pyruvate
lac_idx = intersect(find(cs<203),find(cs>160)); % lactate
ala_idx = intersect(find(cs<260),find(cs>208)); % alanine
bic_idx = intersect(find(cs<105),find(cs>95)); % bicarbonate
hyd_idx = intersect(find(cs<310),find(cs>290)); % hydrate
