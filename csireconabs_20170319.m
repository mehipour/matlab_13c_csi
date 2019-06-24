function [fnorm8,kspace,RE,IM] = csireconabs_20170319(path,lb,deblurring)
% syntax: [fnorm8,RE,IM] = csirecon(path,lb,deblurring
% code by Steve Kadlecek.
% edited by MP on 10/2/15
%    close all;
% updated by MP to check the bandwidth
% updated by MP to give the real and imaginary signals as an output. 
%
% 6/19/16
% updated by MP to have both real and magnitude of the spectra as output.
%
% 6/23/16
% added deblurring as an input. (starting range should be around 0.00006
%
% 3/5/17
% clearned up the function to only include the magnitude recon.
%
% 3/19/17
% includes line broadening as an input argument, also shows the deblurred
% signal and shows the raw signal az a function of acquisition time. 
%
% 11/26/18
% gives kspaca matrix as an output.


[RE1 IM1] = varianloadfid(path,1,1);

n = 1:length(RE1(:));
w = exp(deblurring*n');
w1 = reshape(w,size(RE1,1),size(RE1,2));
RE = RE1.*w1  ;
IM = IM1.*w1;
c = RE + 1i * IM;

% plot and save the acquired and deblurred signal
tr = readprocpar(path,'tr'); tr = tr(2);
t = linspace(0,size(RE1,2)-1,size(RE1,1)*size(RE1,2))*tr;
figure(120);
plot(t,RE(:),t,RE1(:));
xlabel('seconds'); title('raw signal)');
legend('deblurred','acquired signal');

% k-space ordering
gx = 1+[7 7 6 7 8 6 8 6 8 7 5 7 7 9 8 5 6 6 8 9 5 9 7 5 5 9 9 4 7 7 10 6 6 7 4 4 8 10 8 10 5 9 9 10 7 4 4 5 10 3 7 7 11 3 8 7 6 3 8 11 6 11 10 10 4 4 7 3 9 5 11 3 9 5 11 2 7 7 3 10 11 10 4 4 7 3 11 12 7 2 2 6 8 8 12 6 12 2 5 7 5 12 2 9 9 12 11 3 11 3 7 2 12 2 4 10 10 4 12 1 7 7 7 13 8 1 8 1 6 13 6 13 7 5 1 1 13 9 5 9 13 11 12 7 12 11 3 2 2 3 4 13 4 10 7 1 10 1 13 7 0 7 14 12 12 7 6 0 8 8 2 2 6 14 0 14 7 3 11 1 13 13 11 1 3 9 5 7 0 14 5 9 0 14 4 14 0 4 7 10 0 10 14 13 1 12 2 12 13 7 2 1 7 15 14 11 0 3 0 6 7 3 8 14 15 11 15 9 5 15 15 7 1 13 13 1 15 4 10 15 14 2 7 0 12 2 14 12 0 3 15 11 15 7 13 14];
gy = 1+[7 6 7 8 7 6 6 8 8 5 7 7 9 7 5 8 5 9 9 6 6 8 7 9 5 5 9 7 10 4 7 10 4 7 8 6 4 6 10 8 4 4 10 5 7 5 9 10 9 7 11 3 7 8 3 7 3 6 11 6 11 8 10 4 10 4 7 5 11 3 5 9 3 11 9 7 2 7 10 11 4 3 11 3 12 4 10 7 7 8 6 2 12 2 6 12 8 9 2 7 12 5 5 12 2 9 3 11 11 3 7 10 4 4 2 12 2 12 10 7 13 7 1 7 1 6 13 8 13 6 1 8 7 1 9 5 5 1 13 13 9 12 3 7 11 2 12 3 11 2 13 4 1 1 7 4 13 10 10 0 7 14 7 2 12 7 0 6 14 0 2 12 14 6 8 8 7 1 1 11 3 11 13 3 13 0 0 7 5 5 14 14 9 9 14 4 4 0 7 14 10 0 10 12 12 1 13 13 2 7 1 2 15 7 3 0 3 14 11 15 7 0 15 11 6 14 8 15 15 5 9 7 13 13 1 1 4 15 15 10 12 14 7 2 14 0 2 0 12 15 3 15 11 7 14 1];

% place into k-space matrix 'd', and apply line broadening.
sw = readprocpar(path,'sw'); sw = sw(2);
n = 1:size(RE1,1);
for j = 1:length(gx)
   if((j==1) || ((gx(j) ~= gx(1)) || (gy(j) ~= gy(1))))
       d(gx(j),gy(j),:)=c(:,j).*exp(-lb/sw*n');
   end
end
kspace = d;
d=fftshift(fftn(d));

% where the known peaks are and aren'ts
NP = size(RE,1);

fnorm8 = rot90(fliplr(abs(d)),1);
fnorm8 = fnorm8/max(fnorm8(:));
