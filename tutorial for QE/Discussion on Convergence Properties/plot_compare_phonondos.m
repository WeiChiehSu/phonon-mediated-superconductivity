%%% INPUT PARAMETER %%%
material_name = 'phonondos k-mesh compare';
legend_name1 = '6-12-48'
legend_name2 = '6-16-48'
legend_name3 = '6-18-54'
legend_name4 = '6-24-48'
xmin = 0;    % energy range 
xmax = 8.5;
ymin =  0;    % DOS range
ymax =  0.4;
col = [1 0 0;0 0 1;0 1 0;0 1 1;1 0 1;1 1 0;0 0 0];
%%%%%%%%%%%%%%%%%%%%%%%%%%
load('12dos_data.mat')
plot(dos(:,1),dos(:,2)','-','Color',col(3,:),'LineWidth',2); 
ylabel('F(w) (modes/frequency)'); xlabel('frequency (THz)');
axis([xmin xmax ymin ymax]);
hold on
load('16dos_data.mat')
plot(dos(:,1),dos(:,2)','-','Color',col(4,:),'LineWidth',2); 
ylabel('F(w) (modes/frequency)'); xlabel('frequency (THz)');
axis([xmin xmax ymin ymax]);
hold on
load('18dos_data.mat')
plot(dos(:,1),dos(:,2)','-','Color',col(7,:),'LineWidth',2); 
ylabel('F(w) (modes/frequency)'); xlabel('frequency (THz)');
axis([xmin xmax ymin ymax]);
hold on
load('24dos_data.mat')
plot(dos(:,1),dos(:,2)','-','Color',col(1,:),'LineWidth',2); 
ylabel('F(w) (modes/frequency)'); xlabel('frequency (THz)');
axis([xmin xmax ymin ymax]);
hold on
box on;
%legend({legend_name1,legend_name2},'Location','northeast','NumColumns',1)
legend({legend_name1,legend_name2,legend_name3,legend_name4},'Location','northwest','NumColumns',1)
set(gca,'FontSize',15)
title(material_name);
set(gca,'linewidth',2);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
saveas(gcf,['phonondos k-mesh compare' '.png']);
