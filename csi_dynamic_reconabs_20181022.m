function [mrsi_abs,mrsi_complex,RE,IM] = csi_dynamic_reconabs_20181022(path,lb,deblurring,Ns)
% syntax: [mrsi_abs,mrsi_complex,RE,IM] =
% csi_dynamic_reconabs_20181022(path,lb,deblurring,Ns);
% code by Mehrdad Pourfathi on 10/22/2018 based on csireconabs_20170319
%
% Update (1) by MP on 10/23/2018
% In addition to the magnitude MRSI, the function also provides the complex
% MRSI as an output argument. 

[RE1,IM1] = varianloadfid(path,1,1);

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
% 
% % k-space ordering
gx = 4 + [0 1 1 0 -1 -1 -1 0 1 2 2 2 2 1 0 -1 -2 -2 -2 -2 -2 -1 0 1 2 3 3 3 3 3 3 2 1 0 -1 -2 -3 -3 -3 -3 -1 0 1 2 4 4 4 4 2 1 0 -1];
gy = 4 + [0 0 1 1 1 0 -1 -1 -1 -1 0 1 2 2 2 2 2 1 0 -1 -2 -2 -2 -2 -2 -2 -1 0 1 2 3 3 3 3 3 3 2 1 0 -1 -3 -3 -3 -3 -1 0 1 2 4 4 4 4];

Ni = floor(size(RE,2)/length(gx)/Ns);

d = zeros(8,8,size(RE,1),Ni,Ns);

% place into k-space matrix 'd', and apply line broadening.
sw = readprocpar(path,'sw'); sw = sw(2);
n = 1:size(RE1,1);
for kk = 1:Ni
    idx = (kk-1)*52;
    for j = 1:length(gx)
       if((j==1) || ((gx(j) ~= gx(1)) || (gy(j) ~= gy(1))))
           d(gx(j),gy(j),:,kk)=c(:,idx+j).*exp(-lb/sw*n');
       end
    end
    d(:,:,:,kk,:) = squeeze(fftshift(fftn(d(:,:,:,kk,:))));
end


% where the known peaks are and aren'ts
NP = size(RE,1);

mrsi_complex = rot90(fliplr(d),1);
mrsi_abs = abs(mrsi_complex)/max(abs(mrsi_complex(:)));
