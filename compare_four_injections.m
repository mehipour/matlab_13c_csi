%% need to run the code for all injections and then name them lac1, pyr1, lac2, pyr2, ...

figure;

Imax_pyr = 350;
Imax_lac = 100;
Imax_lac2pyr = 1;
Imin_pyr = 0;
Imin_lac = 0;
Imin_lac2pyr = 0;



subplot(341);
imagesc(pyr1);
colorbar;
caxis([Imin_pyr Imax_pyr]);

subplot(345)
imagesc(lac1);
colorbar;
caxis([Imin_lac Imax_lac]);

subplot(349);
imagesc(lac1./pyr1);
colorbar;
caxis([Imin_lac2pyr Imax_lac2pyr]);


subplot(342);
imagesc(pyr2);
colorbar;
caxis([Imin_pyr Imax_pyr]);

subplot(346)
imagesc(lac2);
colorbar;
caxis([Imin_lac Imax_lac]);

subplot(3,4,10);
imagesc(lac2./pyr2);
colorbar;
caxis([Imin_lac2pyr Imax_lac2pyr]);


subplot(343);
imagesc(pyr3);
colorbar;
caxis([Imin_pyr Imax_pyr]);

subplot(347);
imagesc(lac3);
colorbar;
caxis([Imin_lac Imax_lac]);

subplot(3,4,11);
imagesc(lac3./pyr3);
colorbar;
caxis([Imin_lac2pyr Imax_lac2pyr]);



subplot(344);
imagesc(pyr4);
colorbar;
caxis([Imin_pyr Imax_pyr]);

subplot(348);
imagesc(lac4);
colorbar;
caxis([Imin_lac Imax_lac]);

subplot(3,4,12);
imagesc(lac4./pyr4);
colorbar;
caxis([Imin_lac2pyr Imax_lac2pyr]);


colormap jet;