%% plot_prm_date
% file created by MP on 04/26/2017
%
% update (1) by MP on 4/27/2017
% added histgrams and save figures
%
% update (2) by MP on 3/14/2018
% fits lac2pyr of every voxel to a line to obtain trend, also can show the
% histograms and lac vs pyr plots for left and right lung separately if
% manual masking is applied.

%% arrange dataset
% get actual images
pyr_all_mrsi(:,:,prm_counter) = pyr_img;
lac_all_mrsi(:,:,prm_counter) = lac_img;
% get interpolated images
pyr_all_img(:,:,prm_counter) = pyr_imgi;
lac_all_img(:,:,prm_counter) = lac_imgi;

% figure folder
temp = strfind(data_path,'/');
injection_id = data_path(end-1:end);
fig_folder = data_path(1:temp(end-1));

pyr1 = pyr_imgi;
lac1 = lac_imgi;

%% plot lactate vs. pyruvate
if ~manual_mask
    % put all images in vectors
    pyr_all(:,prm_counter) = pyr_imgi(:);
    lac_all(:,prm_counter) = lac_imgi(:);

    figure(7009);
    subplot(2,2,prm_counter);
    plot(pyr1(:),lac1(:),'o');
    title(strcat('inj',num2str(prm_counter)));
    xlabel('pyruvate');
    ylabel('lactate');
    xlim([0 max(pyr_all_mrsi(:))]);
    ylim([0 max(lac_all_mrsi(:))]);

    if and(save_fig,process_ended)
        save_figure('lac_vs_pyr',fig_folder,1,1,0)
    end

    if process_ended
        figure(8000);
        plot(pyr_all,lac_all,'o');
        xlabel('pyruvate');
        ylabel('lactate');
        legend(num2str([1:prm_counter]'))
        xlim([0 max(pyr_all_mrsi(:))]);
        ylim([0 max(lac_all_mrsi(:))]);
        save_figure('lac_vs_pyr_all',fig_folder,1,1,0)
    end
else
    % for masked images
    
    % put all images in vectors
    aux = pyr_imgi.*llmask;
    pyr_left(:,prm_counter) = aux(:);
    aux = pyr_imgi.*rlmask;
    pyr_right(:,prm_counter) = aux(:);
    aux = lac_imgi.*llmask;
    lac_left(:,prm_counter) = aux(:);
    aux = lac_imgi.*rlmask;
    lac_right(:,prm_counter) = aux(:);
    
    figure(7009);
    subplot(2,2,prm_counter);
    plot(pyr_left(:,prm_counter),lac_left(:,prm_counter),'o'); hold on;
    plot(pyr_right(:,prm_counter),lac_right(:,prm_counter),'x'); hold off;
    legend('left lung','right lung')

    title(strcat('inj',num2str(prm_counter)));
    xlabel('pyruvate');
    ylabel('lactate');
    xlim([0 max(pyr_all_mrsi(:))]);
    ylim([0 max(lac_all_mrsi(:))]);

    if and(save_fig,process_ended)
        save_figure('lac_vs_pyr',fig_folder,1,1,0)
    end

    if process_ended
        figure(8000);
        plot(pyr_left,lac_left,'o');
        xlabel('pyruvate');
        ylabel('lactate');
        legend(num2str([1:prm_counter]'))
        xlim([0 max(pyr_all_mrsi(:))]);
        ylim([0 max(lac_all_mrsi(:))]);
        title('left lung')
        save_figure('lac_vs_pyr_left',fig_folder,1,1,0);
        
        figure(8001);
        plot(pyr_right,lac_right,'x');
        xlabel('pyruvate');
        ylabel('lactate');
        legend(num2str([1:prm_counter]'))
        xlim([0 max(pyr_all_mrsi(:))]);
        ylim([0 max(lac_all_mrsi(:))]);
        title('right lung')
        save_figure('lac_vs_pyr_right',fig_folder,1,1,0)
    end
    
end

%% plot lactate-to-pyruvate vs. pyruvate

lac2pyr1 = lac1./pyr1;

figure(8002);

subplot(2,2,prm_counter);
plot(pyr1(:),lac2pyr1(:),'o');
title(strcat('inj',num2str(prm_counter)));
xlabel('pyruvate');
ylabel('lactate-to-pyruvate');
% xlim([0 1]);
% ylim([0 1.2]);

if and(save_fig,process_ended)
    save_figure('lac2pyr_vs_pyr',fig_folder,1,1,0)
end


if process_ended
    figure(8003);
    plot(pyr_all,lac_all./pyr_all,'o');
    legend(num2str([1:prm_counter]'))
    xlabel('pyruvate');
    ylabel('lactate-to-pyruvate');
%     xlim([0 1]); 
%     ylim([0 1.2]);
    save_figure('lac2pyr_vs_pyr_all',fig_folder,1,1,0)
end


%% plot lactate-to-pyruvate histograms
if process_ended
    
    if ~manual_mask
        figure(8004);
        % injection 1
        subplot(221)
        a1 = lac_all(:,1)./pyr_all(:,1); a2 = a1(a1<2); a3 = a2(a2>0);
        histf(a3,50); xlim([0 2]);
        title('inj 1'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        % injection 2
        subplot(222)
        a1 = lac_all(:,2)./pyr_all(:,2); a2 = a1(a1<2); a3 = a2(a2>0);
        hist(a3,50); xlim([0 2]);
        title('inj 2'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        % injection 3
        subplot(223)
        a1 = lac_all(:,3)./pyr_all(:,3); a2 = a1(a1<2); a3 = a2(a2>0);
        hist(a3,50); xlim([0 2]);
        title('inj 3'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        % injection 4
        subplot(224)
        a1 = lac_all(:,4)./pyr_all(:,4); a2 = a1(a1<2); a3 = a2(a2>0);
        hist(a3,50); xlim([0 2]);
        title('inj 4'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
    else
        % for different injections
        bins = 25;
        figure(8004);
        % injection 1
        subplot(221)
        a1 = lac_left(:,1)./pyr_left(:,1); a2 = a1(a1<2); a3 = a2(a2>0);
        histogram(a3,bins,'facecolor',[1 0 0],'facealpha',0.3,'edgecolor','none'); hold on;
        a4 = lac_right(:,1)./pyr_right(:,1); a5 = a4(a4<2); a6 = a5(a5>0);
        histogram(a6,bins,'facecolor',[0 0 1],'facealpha',0.3,'edgecolor','none'); hold off;
        box off; legend('left','right'); xlim([0 0.5])
        title('inj 1'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        % injection 2
        subplot(222)
        a1 = lac_left(:,2)./pyr_left(:,2); a2 = a1(a1<2); a3 = a2(a2>0);
        histogram(a3,bins,'facecolor',[1 0 0],'facealpha',0.3,'edgecolor','none'); hold on;
        a4 = lac_right(:,2)./pyr_right(:,2); a5 = a4(a4<2); a6 = a5(a5>0);
        histogram(a6,bins,'facecolor',[0 0 1],'facealpha',0.3,'edgecolor','none'); hold off;
        box off; legend('left','right'); xlim([0 0.5])
        title('inj 2'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        % injection 3
        subplot(223)
        a1 = lac_left(:,3)./pyr_left(:,3); a2 = a1(a1<2); a3 = a2(a2>0);
        histogram(a3,bins,'facecolor',[1 0 0],'facealpha',0.3,'edgecolor','none'); hold on;
        a4 = lac_right(:,3)./pyr_right(:,3); a5 = a4(a4<2); a6 = a5(a5>0);
        histogram(a6,bins,'facecolor',[0 0 1],'facealpha',0.3,'edgecolor','none'); hold off;
        box off; legend('left','right'); xlim([0 0.5])
        title('inj 3'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        % injection 4
        subplot(224)
        a1 = lac_left(:,4)./pyr_left(:,4); a2 = a1(a1<2); a3 = a2(a2>0);
        histogram(a3,bins,'facecolor',[1 0 0],'facealpha',0.3,'edgecolor','none'); hold on;
        a4 = lac_right(:,4)./pyr_right(:,4); a5 = a4(a4<2); a6 = a5(a5>0);
        histogram(a6,bins,'facecolor',[0 0 1],'facealpha',0.3,'edgecolor','none'); hold off;
        box off; legend('left','right'); xlim([0 0.5])
        title('inj 4'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        
        % for different sides
        figure(8005);
        % injection 1
        subplot(121)
        a1 = lac_left(:,1)./pyr_left(:,1); b1 = a1(a1<2); c1 = b1(b1>0);
        a2 = lac_left(:,2)./pyr_left(:,2); b2 = a2(a2<2); c2 = b2(b2>0);
        a3 = lac_left(:,3)./pyr_left(:,3); b3 = a3(a3<2); c3 = b3(b3>0);
        a4 = lac_left(:,4)./pyr_left(:,4); b4 = a4(a4<2); c4 = b4(b4>0);
        histogram(c1,bins,'facecolor',[19 139 67]/256,'facealpha',0.3,'edgecolor','none'); hold on;
        histogram(c2,bins,'facecolor',[21 118 187]/256,'facealpha',0.3,'edgecolor','none'); hold on;
        histogram(c3,bins,'facecolor',[89 45 140]/256,'facealpha',0.3,'edgecolor','none'); hold on;
        histogram(c4,bins,'facecolor',[236 30 35]/256,'facealpha',0.3,'edgecolor','none'); hold on;
        box off; legend('inj1','inj2','inj3','inj4'); xlim([0 0.5]);
        title('left'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        
        % injection 2
        subplot(122)
        a1 = lac_right(:,1)./pyr_right(:,1); b1 = a1(a1<2); c1 = b1(b1>0);
        a2 = lac_right(:,2)./pyr_right(:,2); b2 = a2(a2<2); c2 = b2(b2>0);
        a3 = lac_right(:,3)./pyr_right(:,3); b3 = a3(a3<2); c3 = b3(b3>0);
        a4 = lac_right(:,4)./pyr_right(:,4); b4 = a4(a4<2); c4 = b4(b4>0);
        histogram(c1,bins,'facecolor',[19 139 67]/256,'facealpha',0.3,'edgecolor','none'); hold on;
        histogram(c2,bins,'facecolor',[21 118 187]/256,'facealpha',0.3,'edgecolor','none'); hold on;
        histogram(c3,bins,'facecolor',[89 45 140]/256,'facealpha',0.3,'edgecolor','none'); hold on;
        histogram(c4,bins,'facecolor',[236 30 35]/256,'facealpha',0.3,'edgecolor','none'); hold on;
        box off; legend('inj1','inj2','inj3','inj4'); xlim([0 0.5]);
        title('right'); xlabel('lactate-to-pyruvate'); ylabel('frequency');
        
    end

    if save_fig
        save_figure('hist_all_plot',fig_folder,1,1,0)
    end
      
    
    %% fit lines to find trend
    lac2pyr_all_img =  lac_all_mrsi./pyr_all_mrsi;
    % polynomial fit order
    N = 1;
    lac2pyr_trend_img = zeros([size(pyr_img),N]);
    lac2pyr_trend_imgii = zeros([size(pyr_imgi),N]);

    x = [0; 1; 2.5; 4];  % time in hours'
    xfit = 0:0.5:4;
    figure(1525);
    for ii = 1:size(pyr_img,1)
        for jj = 1:size(pyr_img,2)
            y = squeeze(lac2pyr_all_img(ii,jj,:));
            if ~isnan(y(1))
                p = polyfit(x,y,N);
                for nn = 1:N+1
                    lac2pyr_trend_img(ii,jj,nn) = p(nn);
                end

                yfit = polyval(p,xfit);
                plot(x,y,'o',xfit,yfit);
                drawnow();
            end

        end
    end

    figure(1546); 
    
    for nn = 1:N+1
        subplot(2,2,nn)
        lac2pyr_trend_imgii(:,:,nn) = interpolate_image(lac2pyr_trend_img(:,:,nn),Ni_maps);
        imagesc(squeeze(lac2pyr_trend_imgii(:,:,nn)).*mask); 
        colorbar; colormap jet; 
        title(['p^',num2str(N-nn+1)]); 
        axis square;
    end
    
    pyr_all_img(:,:,prm_counter) = pyr_imgi;
    lac_all_img(:,:,prm_counter) = lac_imgi;
    
    
end


