function img = csireconphased_20170319_carbon(data_path,lb,debluring ,fastrun,flow,lac_bigger_than_pyr)


%% Syntax: 
% img = csireconphased_20160912_steve(data_path,lb,debluring,fastrun,flow,lac_bigger_than_pyr)
%
% Create by Stephen Kadlecek
%
% Updated (1) Mehrdad Pourfathi on 9/12/16 
% if fastrun is 1 then does not plot fits
%
% Updated (2) by Mehrdad Pourfathi on 10/21/16
% saves the processed data and scaled images for all experiments. 
%
% Updated (3) by Mehrdad Pourfathi on 12/01/16
% added flow as an input for the flow suppressed sequence to changes the
% first order phase
%
% Upated (4) by MP on 12/05/16
% No more thresholding applied spectra during fitting!
%
% Upated (5) by MP on 01/13/17
% Added a condition to save data in a folder for liver studies. 
%
% Updated (6) by MP on 02/23/17
% generates the filename and the location to save the file in a smarter
% way.
%
% Upated (7) by MP on 03/08/17
% has the "lac_bigger_than_pyruvate" input flag if needed.
%
% Upated (8) by MP on 03/19/17
% line broadening now is an input argument, also changed how debluring is
% applied.



global spectprime;
global spectprimephased;
global csppm;
global normhist;
global normhistx;
global x0;
global sfrq;
global sw;
global fixed;
global lwidx;
global bkimg;
global pyridx;
global hydidx;
global xscale;
global j;
global k;
global ms;
global stats;
global images;
global show_fit_steps
show_fit_steps = ~fastrun;
% close all;

% lines broader than this are considered lung
lungthresh = 30;

% chemical shift in ppm, relative to pyruvate
csppm = [0 -10.11 5.70 8.285 12.1 -46.51];
if lac_bigger_than_pyr
    csppm = [0 -10.11 5.70 -7.3 12.1 -46.51] - 12.1;
end

% show_fit_steps = 1; 

% indices of peaks
pyridx = 1; bicidx = 2; alaidx = 3;  hydidx = 4; lacidx = 5; CO2idx = 6;
graphtitle = {'pyruvate','bicarb','alanine','hydrate','lactate','CO2','common lw (Hz)','CO2 lw (Hz)','lac lw (Hz)'};
% basedir = '/Users/mehipour/Desktop/data';

if flow
    files = {{'', 'pyruvate', pyridx, 1,'',8, ''},};
else
    files = {{'', 'pyruvate', pyridx, 1,'',13, ''},};
end

%deblur = -3;
%files = { {'20151015_rat02hcl/carbon data', 'bicarb',1,'inj4/2dCSIv1_11',9,''} };

for fidx = 1:length(files)
voxelist = {};
for sidx = 1:files{fidx}{4}
   stats(fidx,sidx,1:4)=0;
   bicarbinjection = (files{fidx}{2}(1)=='b');
   graphscaling = [1 10-9*bicarbinjection 5 5 5 10 .025 .01 .025];
   ph1range = files{fidx}{files{fidx}{4}+5};
   % read sw, sfrq
   sw = readprocpar(data_path, 'sw');
   sfrq = readprocpar(data_path, 'sfrq');
   ms = readprocpar(data_path, 'nv');
   gain = readprocpar(data_path, 'gain');
   if (ms ~= 16)
       'ms should be 16'
       return;
   end
   % read background image
   bkimg = [];
   if(~isempty(files{fidx}{files{fidx}{4}+6}))
       bkimg = fdfread([basedir '/' files{fidx}{files{fidx}{4}+6}]);
       bkimg = bkimg / max(max(bkimg));
   end
   
   % read raw varian data
   [RE1 IM1] = varianloadfid(data_path, 1, 1);
   
   % adjust for gain
   RE1 = RE1 / 2^(gain/6);
   IM1 = IM1 / 2^(gain/6);
   
   % debluring
   n = 1:length(RE1(:));
   w = exp(debluring*n');
   w1 = reshape(w,size(RE1,1),size(RE1,2));
   RE = RE1.*w1  ;
   IM = IM1.*w1;

   % line broadening
   for j = 1:size(RE,2)
       for k = 1:size(RE,1)
           RE(k,j) = RE(k,j)*exp(-k/sw*lb);
           IM(k,j) = IM(k,j)*exp(-k/sw*lb);
       end
   end
   
   % k-space encoding order
   gx = 1+[7 7 6 7 8 6 8 6 8 7 5 7 7 9 8 5 6 6 8 9 5 9 7 5 5 9 9 4 7 7 10 6 6 7 4 4 8 10 8 10 5 9 9 10 7 4 4 5 10 3 7 7 11 3 8 7 6 3 8 11 6 11 10 10 4 4 7 3 9 5 11 3 9 5 11 2 7 7 3 10 11 10 4 4 7 3 11 12 7 2 2 6 8 8 12 6 12 2 5 7 5 12 2 9 9 12 11 3 11 3 7 2 12 2 4 10 10 4 12 1 7 7 7 13 8 1 8 1 6 13 6 13 7 5 1 1 13 9 5 9 13 11 12 7 12 11 3 2 2 3 4 13 4 10 7 1 10 1 13 7 0 7 14 12 12 7 6 0 8 8 2 2 6 14 0 14 7 3 11 1 13 13 11 1 3 9 5 7 0 14 5 9 0 14 4 14 0 4 7 10 0 10 14 13 1 12 2 12 13 7 2 1 7 15 14 11 0 3 0 6 7 3 8 14 15 11 15 9 5 15 15 7 1 13 13 1 15 4 10 15 14 2 7 0 12 2 14 12 0 3 15 11 15 7 13 14]; 
   gy = 1+[7 6 7 8 7 6 6 8 8 5 7 7 9 7 5 8 5 9 9 6 6 8 7 9 5 5 9 7 10 4 7 10 4 7 8 6 4 6 10 8 4 4 10 5 7 5 9 10 9 7 11 3 7 8 3 7 3 6 11 6 11 8 10 4 10 4 7 5 11 3 5 9 3 11 9 7 2 7 10 11 4 3 11 3 12 4 10 7 7 8 6 2 12 2 6 12 8 9 2 7 12 5 5 12 2 9 3 11 11 3 7 10 4 4 2 12 2 12 10 7 13 7 1 7 1 6 13 8 13 6 1 8 7 1 9 5 5 1 13 13 9 12 3 7 11 2 12 3 11 2 13 4 1 1 7 4 13 10 10 0 7 14 7 2 12 7 0 6 14 0 2 12 14 6 8 8 7 1 1 11 3 11 13 3 13 0 0 7 5 5 14 14 9 9 14 4 4 0 7 14 10 0 10 12 12 1 13 13 2 7 1 2 15 7 3 0 3 14 11 15 7 0 15 11 6 14 8 15 15 5 9 7 13 13 1 1 4 15 15 10 12 14 7 2 14 0 2 0 12 15 3 15 11 7 14 1];

   ksi = zeros(ms,ms,size(RE,1));
   for j = 1:size(RE,2)
       if((j==1) || ((gx(j) ~= gx(1)) || (gy(j) ~= gy(1))))
           ksi(gx(j),gy(j),:) = (RE(:,j) + 1i*IM(:,j));
       end
   end
   fti = fftshift(fftn(ksi));
   fti = fti/max(max(max(normn(fti))));
   % identity strongest line in k=0 spectrum as pyruvate
   k0norm = normn(fftshift(fft(RE(:,1)+1i*IM(:,1))));
   [maxval maxidx] = max(k0norm);
   xscale = -((1:length(k0norm))-maxidx) / length(k0norm) * sw / sfrq + csppm(files{fidx}{3})-csppm(pyridx);
   
%    % if lactate is bigger than overall pyruvate run this.
%    xscale = xscale + csppm(lacidx);

   
   % calculate noise threshold
   figure(1);
   for j=1:size(fti,1)
   for k=1:size(fti,2)
       plot((j-1+(0:(size(fti,3)-1))*.98/size(fti,3))/ms*size(bkimg,1),((ms-k+0)-normn(squeeze(fti(j,k,:)))/1)/ms*size(bkimg,2));
       [maxval maxidx] = max(normn(squeeze(fti(j,k,:))));
       ftinorm((j-1)*size(fti,2)+k) = maxval;
   end
   end
   hold off;
   if show_fit_steps
       figure(1);
       [normhist normhistx] = hist(ftinorm, 60);
       [maxval maxidx] = max(normhist);
       normhist = normhist / maxval;
       x0 = fminsearch(@texptfit, [1 normhistx(maxidx)], optimset('Display','off'));
       thresh = 0 * x0(2);
   else
       thresh = 0;
   end
   % fit individual spectra, assemble peak amplitudes into metabolite images
   images = zeros(1,1,ms,ms,7);
   img = zeros(ms,ms,128);
   
   for j=1:size(fti,1)
   j
   for k=1:size(fti,2)    
       
       spect=squeeze(fti(j,k,:))'*(-1)^(j+k);
       [scaling maxidx] = max(normn(spect));
%        if(scaling < thresh || (abs(xscale(maxidx)) > 2 && ~bicarbinjection))
%            continue;
%        end
       spect = spect / scaling;
       % do a rough phase
       bestph0 = 0;
       minfom = 1E+6;
       ph1 = mean(ph1range);
       for ph0=0:.01:2*pi
           spectprimephased = real(spect.*exp(1i*(ph0+ph1*(1:length(spect))/length(spect))));
           spectprimephased(spectprimephased>0)=0;
           fom=sum(spectprimephased.*spectprimephased);
           if(fom<minfom)
               minfom=fom;
               bestph0 = ph0;
           end
       end
       spectprimephased = real(spect.*exp(1i*(bestph0+ph1*(1:length(spect))/length(spect))));
       % eliminate peaks to get a first guess at the baseline
       spectprimephasednopeaks = spectprimephased;
       xscalenopeaks = xscale;
       for r=1:length(csppm)
           spectprimephasednopeaks = spectprimephasednopeaks(abs(xscalenopeaks-csppm(r))>3);
           xscalenopeaks = xscalenopeaks(abs(xscalenopeaks-csppm(r))>3);
       end
       ws = warning('off','all');  % Turn off warning
       p = polyfit(xscalenopeaks,spectprimephasednopeaks,6);
       warning(ws);
       spectprimephased = spectprimephased - polyval(p,xscale);
       plot(spectprimephased)
       %% added this line by MP to save images.
       
       img(k,j,:) = spectprimephased* scaling;
       %%
       % fit parameters are x = [<line 1 ampl> <line 1 position> <line 2 ampl> <line 2 tweak> ... <line length(csppm) ampl> 
       %              <line length(csppm) tweak> <lw 1> <lw 2> <lw 3> <ph0> <ph1>]
       x0 = [zeros(1,2*length(csppm)) .2 1 .2];
       for r=1:length(csppm)
           x0(2*r-1) = .1 + .9*((r==pyridx)|((r==bicidx)&bicarbinjection));
       end
       lwidx = ones(1,length(csppm));
       lwidx(CO2idx) = 2;
       %lwidx(lacidx) = 3;
       fixed = [zeros(1,2*length(csppm)) 0 0 0];
       fixed(2*hydidx-1) = 1;
       for s=1:5   % fit iteration loop
       for r=1:length(csppm)
           fixed(1:(2*length(csppm)))=1;
           fixed((2*r-1):(2*r))=0;
           fixed(2*length(csppm)+2)=(r~=CO2idx);
           fixed(2*length(csppm)+3)=(r~=lacidx); fixed(2*length(csppm)+3) = 1;
           x0 = unpack(fminsearch(@fit, x0(fixed==0), optimset('MaxIter',1000000,'Display','off')), x0, fixed);
           plotfit(scaling);
       end
       end
       plotfitmap(scaling);
       if(x0(2*length(csppm)+1)*sfrq>lungthresh)
           voxelist{length(voxelist)+1} = [j k];
       end
       foundit=0;
       for iv=1:length(voxelist)
           if(j==voxelist{iv}(1) && k==voxelist{iv}(2))
               foundit=1;
               break;
           end
       end
       idx1 = pyridx*(1-bicarbinjection)+bicidx*bicarbinjection;
       idx2 = lacidx*(1-bicarbinjection)+CO2idx*bicarbinjection;
       if(foundit)
           stats(fidx,sidx,1)=stats(fidx,sidx,1)+x0(2*idx1-1)*x0(2*length(csppm)+lwidx(idx1)); % lung pyruvate/bicarb
           stats(fidx,sidx,2)=stats(fidx,sidx,2)+x0(2*idx2-1)*x0(2*length(csppm)+lwidx(idx2)); % lung lactate/CO2
       else
           stats(fidx,sidx,3)=stats(fidx,sidx,3)+x0(2*idx1-1)*x0(2*length(csppm)+lwidx(idx1)); % non-lung pyruvate/bicarb
           stats(fidx,sidx,4)=stats(fidx,sidx,4)+x0(2*idx2-1)*x0(2*length(csppm)+lwidx(idx2)); % non-lung lactate/CO2
       end
       if show_fit_steps
           % store into 9 images: bic area, pyr area, ala area, hyd area, lac area, and the three linewidths. 
           figure(fidx*10+sidx);
           set(gcf,'numbertitle','off','name',data_path(end-15:end))
       end
           images(fidx,sidx,j,k,1:6) = abs(x0(2*(1:6)-1)).*x0(2*length(csppm)+lwidx(1:6))*scaling;
           images(fidx,sidx,j,k,7:9) = x0(2*length(csppm)+(1:3))*sfrq;
           scaledimages = squeeze(squeeze(images(fidx,sidx,:,:,:)));
           scaledimages(:,:,1:6) = scaledimages(:,:,1:6) / max(max(max(scaledimages(:,:,pyridx))));
           scaledimages(scaledimages>1) = 1;
           scaledimages(:,:,7:9) = squeeze(squeeze(images(fidx,sidx,:,:,7:9)));
      if show_fit_steps
           for r = 1:9
               subplot(3,4,r);
               overlay(orient(imresize(scaledimages(:,:,r)*graphscaling(r),4)),imresize(scaledimages(:,:,pyridx)>.1,4));
               title([graphtitle{r} ' ' char(42+(graphscaling(r)<1)*5) sprintf('%d', round(graphscaling(r)^(1-(graphscaling(r)<1)*2)))]);
           end
           subplot(3,4,10);       
           ratioimg = squeeze(squeeze(images(fidx,sidx,:,:,lacidx)./images(fidx,sidx,:,:,pyridx)))*2;
           ratioimg(isnan(ratioimg))=0;
           ratioimg(ratioimg>1)=1;
           overlay(orient(imresize(ratioimg,4)),imresize(squeeze(squeeze(images(fidx,sidx,:,:,pyridx)))>.1,4));
           title('lac:pyr x 2');
           subplot(3,4,11);       
           ratioimg = squeeze(squeeze(images(fidx,sidx,:,:,alaidx)./images(fidx,sidx,:,:,lacidx)));
           ratioimg(isnan(ratioimg))=0;
           ratioimg(ratioimg>1)=1;
           overlay(orient(imresize(ratioimg,4)),imresize(squeeze(squeeze(images(fidx,sidx,:,:,pyridx)))>.1,4));
           title('ala:lac');
           if(bicarbinjection)
               subplot(3,4,12);       
               ratioimg = squeeze(squeeze(images(fidx,sidx,:,:,CO2idx)./images(fidx,sidx,:,:,bicidx)))*5;
               ratioimg(isnan(ratioimg))=0;
               ratioimg(ratioimg>1)=1;
               overlay(orient(imresize(ratioimg,4)),imresize(squeeze(squeeze(images(fidx,sidx,:,:,pyridx)))>.1,4));
               title('CO2:bic x 5');
               subplot(3,4,11);
               phimg = 6.1+log10(squeeze(squeeze(images(fidx,sidx,:,:,bicidx)./images(fidx,sidx,:,:,CO2idx))));
               %phimg(scaledimages(:,:,pyridx)<.1)=6;
               lung2heart(real(orient(phimg)));
               caxis([6.5 7.4]);
               %overlay(orient(imresize((phimg-6.5),4)),imresize(scaledimages(:,:,pyridx)>.01,4));
               title('pH (6.5-7.4)');
               colormap(jet);
           else
               subplot(3,4,6);
               threshlwimg = scaledimages(:,:,length(csppm)+1);
               threshlwimg(threshlwimg<lungthresh) = 0;
               overlay(orient(imresize(threshlwimg*graphscaling(length(csppm)+1),4)),imresize(scaledimages(:,:,pyridx)>.1,4));
               title('lung thresh lw');

           end
       colormap(jet);  
       end
   end
   end
   stats
   % save file name
     
   temp = strfind(data_path,'/');
   if ~debluring
        if ~exist([data_path(1:temp(end-1)) 'deblur0/'],'dir')
            mkdir(data_path(1:temp(end-1)),'deblur0')
        end
        save_name  = [data_path(1:temp(end-1)) 'deblur0' data_path(temp(end):end)];
   else
       if ~exist([data_path(1:temp(end-1)) 'deblur1/'],'dir')
            mkdir(data_path(1:temp(end-1)),'deblur1')
       end
       save_name  = [data_path(1:temp(end-1)) 'deblur1' data_path(temp(end):end)];

   end
   save(save_name,'scaledimages','img')  
   save_figure(save_name,'',1,1,0);
   
end
% save stats stats
end

function a = fit(x)
global spectprime;
global spectprimephased;
global csppm;
global x0;
global sw;
global sfrq;
global fixed;
global lwidx;
global pyridx;
global hydidx;
global xscale;
   % fit parameters are x = [<line 1 ampl> <line 1 position> <line 2 ampl> <line 2 tweak> ... <line length(csppm) ampl> 
   %              <line length(csppm) tweak> <lw common> <lw CO2> <lw lactate>]
   x1 = unpack(x, x0, fixed);
   ampl = abs(x1(1:2:(2*length(csppm))));
   ampl(hydidx) = abs(x1(2*hydidx-1)^2)*ampl(pyridx);
   tweak = x1(2:2:(length(csppm)*2));
   lw = x1((2*length(csppm)+1):(2*length(csppm)+3));
   spectprime = zeros(1,length(spectprimephased));
   for r=1:length(csppm)
       for q=1:length(spectprimephased)
           detuning = xscale(q)-csppm(r)+4*atan(tweak(r))*lw(lwidx(r));
           spectprime(q) = spectprime(q)+ampl(r)/(1+detuning^2/lw(lwidx(r))^2);
       end
   end
   diffspect=spectprime-spectprimephased;
   a=sum(diffspect.^2);
   if (lw(2)>3)
       a = a + (lw(2)-3)^2*length(spectprimephased)^2;
   end
   if (lw(1)>4)
       a = a + (lw(1)-4)^2*length(spectprimephased)^2;
   end
   if (lw(3)>3)
       a = a + (lw(3)-3)^2*length(spectprimephased)^2;
   end
   if (lw(3)<1)
       a = a + (lw(3)-1)^2*length(spectprimephased)^2;
   end
   %x1
   %plotfit(1);

function a=orient(x)
   a=rot90(x);

function plotfit(scaling)
% plot real (left) and imaginary (right) data (blue circles) and fit (green line)
global spectprime;
global spectprimephased;
global j;
global k;
global xscale;
global show_fit_steps

if show_fit_steps
   figure(1);
   set(gcf,'numbertitle','off','name',sprintf('voxel %d,%d',j,k));
   plot(xscale,scaling*spectprime,'o',xscale,scaling*spectprimephased,'r-','LineWidth',2);
   drawnow;
end

function plotfitmap(scaling)
global spectprime;
global spectprimephased;
global j;
global k;
global ms;
global show_fit_steps

if show_fit_steps
   figure(2);
   plot((1:length(spectprime))/length(spectprime)/ms*.95+(j-1)/ms, 3*spectprimephased/ms/100*scaling+(k-1)/ms,'r+',...
       (1:length(spectprime))/length(spectprime)/ms*.95+(j-1)/ms, 3*spectprime/ms/100*scaling+(k-1)/ms,'b', 'LineWidth',2,'MarkerSize',2);
   xlim([0 1]);
   ylim([0 1]);
   axis('off');
   hold on;
end

function a=texptfit(x)
% fit low signal values to t*exp(-t^2) to get an estimate of noise distribution
global normhist;
global normhistx;
   yp = x(1)/x(2)*normhistx.*exp(-normhistx.*normhistx/x(2)^2);
   a = sum((yp-normhist).^2);
   figure(1);
   subplot(1,1,1);
   bar(normhistx,normhist);
   hold on;
   plot(normhistx, yp, 'g', 'LineWidth', 2);
   plot(2*[x(2) x(2)], [0 max(yp)], 'r', 'LineWidth', 2);
   hold off;
   drawnow;

function y = unpack(x, x0, fixed)
   xidx = 1;
   y = x0;
   for r=1:length(fixed)
       if(~fixed(r))
           y(r) = x(xidx);
           xidx = xidx + 1;
       end
   end

function a = normn(x)
% returns a matrix filled with the norms of each (complex) element of x
   for j = 1:size(x,1)
   for k = 1:size(x,2)
       a(j,k) = sqrt(real(x(j,k))^2+imag(x(j,k))^2);
   end
   end

function overlay(img,alpha)
global bkimg;
alpha=alpha*0+.7;
   NCOLOR = 100;
   if(isempty(bkimg))
       imshow(img);
       return;
   end
   jetlookup=jet(NCOLOR); % color lookup table with 100 equally spaced values
   finalimage = zeros(size(img,1),size(img,2),3);
   for(j=1:size(img,1))
   for(k=1:size(img,2))
       jp=j-size(img,2);
       % [1 1 1] is white, so image1 is in grayscale
       % jetlookup contains the jet colorscale
       % alpha contains the desired transparency matrix
       if(round(img(j,k)*NCOLOR) > 0)
           finalimage(j,k,1:3) = bkimg(j,k)*(1-alpha(j,k))*[1 1 1] + jetlookup(min(round(img(j,k)*NCOLOR),NCOLOR),1:3)*alpha(j,k);
       else
           finalimage(j,k,1:3) = bkimg(j,k)*[1 1 1];
       end
   end
   end
   imshow(finalimage);

function a = readprocpar(f, param)
   g = fopen([f '.fid/' 'procpar']);
   while(~feof(g))
       s = fgets(g);
       if (strcmp(strtok(s),param))
           a = strread(fgets(g));
           a = a(2);
           fclose(g);
           return;
       end
   end
   fclose(g);
   a = -1;