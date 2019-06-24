% process the data first using the CSI data processing codes:

center_spec = zeros(128,24);
center_speci = zeros(512,24);
jj = 0;

n = -256:255;
ph0 = -3*pi/4;
ph1 = -0.027;

polyX = [1:172,250:262,299:420,452:512];

for ii = 1:11:256
    jj = jj + 1;
    idx = 1:128;
    idx = idx + (ii-1)+128;
    center_spec(:,jj) = fftshift(fft(RE(:,ii)+1i*IM(:,ii)));
    center_speci(:,jj) = interp1([1:128]',center_spec(:,jj),linspace(1,128,512)');
%     center_speci(:,jj) = abs(center_speci(:,jj)) - mean(abs(center_speci(1:100,jj)),1);
    center_speci_phased(:,jj) = center_speci(:,jj) .* exp(1i*(ph0 + n'*ph1));
%     center_speci_phased2(:,jj) = msbackadj([1:512]',real(center_speci_phased(:,jj)));
    P = polyfit(polyX',real(center_speci_phased(polyX,jj)),1);
    center_speci_phased2(:,jj) = real(center_speci_phased(:,jj)) - polyval(P,1:512)';
    center_speci_phased3(:,jj) = msbackadj([1:512]',real(center_speci_phased2(:,jj)));
    center_speci(:,jj) = abs(center_speci_phased(:,jj));

end

figure(1);
plot(sum(real(center_speci_phased3),2));
%%
figure(2);
show_waterfall(real((center_speci_phased3)),linspace(227,107,512),[150,200],1:1:24,-1.2,-0.2);

lac = sum(abs(center_speci_phased3(175:194,:)),1);
pyrh = sum(abs(center_speci_phased3(197:209,:)),1);
ala = sum(abs(center_speci_phased3(210:220,:)),1);
pyr = sum(abs(center_speci_phased3(224:247,:)),1);
unk = sum(abs(center_speci_phased3(260:272,:)),1);
bic = sum(abs(center_speci_phased3(274:300,:)),1);
co2 = sum(abs(center_speci_phased3(425:450,:)),1);

figure(3);
n = 1:24;
% plot(n,pyr,'b',n,bic,'m',n,lac,'r',n,co2,'g');
plot(n,lac,n,pyrh,n,ala,n,pyr,n,unk,n,bic,n,co2);
legend('lac','pyrh','ala','pyr','unk','bic','co2');