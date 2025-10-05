%%% INPUT PARAMETER %%%
material_name = 'phonon band k-mesh compare';
legend_name1 = '6-12-48'
legend_name2 = '6-16-48'
legend_name3 = '6-18-54'
legend_name4 = '6-24-48'
ymin = 0;    % energy range [meV]
ymax = 42;
nk = 361;
hk = 90;
col = [1 0 0;0 0 1;0 1 0;0 1 1;1 0 1;1 1 0;0 0 0];
%%%%%%%%%%%%%%%%%%%%%%%%%%
load('12phonon_band_data.mat')
plot(kd,Ebnd,'-','Color',col(3,:),'LineWidth',2);
axis([kd(1,1),kd(1,nk),ymin,ymax]);
hold on;
load('16phonon_band_data.mat')
plot(kd,Ebnd,'-','Color',col(4,:),'LineWidth',2);
hold on;
load('18phonon_band_data.mat')
plot(kd,Ebnd,'-','Color',col(7,:),'LineWidth',2);
hold on;
load('24phonon_band_data.mat')
plot(kd,Ebnd,'-','Color',col(1,:),'LineWidth',2);
hold on;
% axis square;
%ylabel('Energy (meV)');
ylabel('frequency (THz)');
title(material_name);
% xlabel();
x=[kd(1,1),kd(1,nk)];
y=[0 0];
plot(x,y,'k--')
%%% Plot high symmetry line %%%
%xticks([kd(1,1:hk:nk)]);
xticks([kd(1,1:hk:(nk-hk)) kd(1,nk)]);
xticklabels({'\Gamma','H','P','\Gamma','N','interpreter','LaTex'});
set(gca,'FontSize',15)
set(gca,'linewidth',2);
xlabelpoints=[kd(1,1:hk:(nk-hk))  kd(1,nk)];
for hh=1:hs
    %x=[kd(1,(1+hk*(hh-1)):hk:(hk*hh)) kd(1,(1+hk*(hh-1)):hk:(hk*hh))];
    x=[xlabelpoints(hh) xlabelpoints(hh)];    
    y=[ymin ymax];
    plot(x,y,'k','linewidth',2)
end
legend({legend_name1,'','',legend_name2,'','',legend_name3,'','',legend_name4,'',''},'Location','northeast','NumColumns',1);
saveas(gcf,['phonon band q-mesh compare' '.png']);
saveas(gcf,['phonon band q-mesh compare' '.fig']);

