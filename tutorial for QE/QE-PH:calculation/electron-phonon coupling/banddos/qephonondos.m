%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% phonon dos: default unit [1/cm]
% change unit from [1/cm] to [meV]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clear 

%%%%%%%%%%%%%%%%%%%%%%%%
name = 'V';
material_name = 'V 61872';
natom = 1;
ndos = 200;
Ry_to_meV = 13.605691930242388 * 1000;
meV_to_1_over_cm = 109737.3157 / Ry_to_meV;
xmin = 0;    % energy range [meV]
xmax = 8;   
ymin = 0;    % DOS range    [modes/meV]
ymax = 0.5;
col = [1 0 0;0 1 0;0 0 1;0 1 1;1 0 1;1 1 0;0 0 0];
if (1 + natom) > 7
   col_tmp = zeros(1+natom,3);
   col_tmp(1:7,:) = col(:,:);
   for i = 8:(1+natom)
       col_tmp(i,:) = rand(1,3);
   end
   col = col_tmp;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
% fid=fopen([ name '.dos'],'r');
% row={};
% while ~feof(fid)
%   thisline = fgetl(fid);
%   row{end+1,1} = thisline;
% end
% nrow=numel(row);
% fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%
% column: energy, total dos, projected 1 atom dos, projected 2 atom dos, etc.                                                  
fid=fopen([ name '.dos'],'r');

fgetl(fid);                  
dos = fscanf(fid,repmat('%f ',1,2+natom),[2+natom ndos])'; fgetl(fid);
%dos(:,1) = dos(:,1) / meV_to_1_over_cm;
dos(:,1) = dos(:,1) /33.3563;
dos(:,2:end) = dos(:,2:end) * meV_to_1_over_cm;
normalize = sum(dos(:,2),1) * max(dos(:,1)) / ndos;
fclose(fid);
%%% plot %%%
mkdir dos
cd dos
%%% total %%%
figure;
hold on
plot(dos(:,1),dos(:,2)','-','Color',col(1,:),'LineWidth',1.75); 
%ylabel('F(w) (modes/meV)'); xlabel('Energy (meV)');
ylabel('F(w) (modes/frequency)'); xlabel('frequency (THz)');
legend(' total dos ');
axis([xmin xmax ymin ymax]);
title([ 'phonon dos, ' material_name ]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
saveas(gcf,['dos_total' '.png']);
%%% all %%%
figure;
hold on
legend_name = cell(1+natom,1);
for i_natom = 1:(1+natom)
    tmp = plot(dos(:,1),dos(:,1+i_natom)','-','Color',col(i_natom,:),'LineWidth',1.75); 
    tmp_2(i_natom) = tmp;
    if i_natom ==1
        legend_name{i_natom,1} = ' total dos ';
    else
        legend_name{i_natom,1} = [ ' the ' num2str(i_natom-1) ' dos'];
    end
end
legend(tmp_2,{char(legend_name)});
%ylabel('F(w) (modes/meV)'); xlabel('Energy (meV)');
ylabel('F(w) (modes/frequency)'); xlabel('frequency (THz)');
axis([xmin xmax ymin ymax]);
title([ 'phonon dos, ' material_name ]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
saveas(gcf,['dos_all' '.png']);
%%% projected atom dos %%%
for i_natom = 1:natom
    figure;
    hold on
    plot(dos(:,1),dos(:,2+i_natom)','-','Color',col(1+i_natom,:),'LineWidth',1.75); 
    legend([ ' the ' num2str(i_natom) ' dos']);
    %ylabel('F(w) (modes/meV)'); xlabel('Energy (meV)');
    ylabel('F(w) (modes/frequency)'); xlabel('frequency (THz)');
    axis([xmin xmax ymin ymax]);
    title([ 'phonon dos, ' material_name ' , projected atom dos']);
    set(gca,'linewidth',2);
    % set(gca,'Ticklength',[0.02 0.035]);
    set(gca,'FontSize',15)
    set(gca,'XMinorTick','on')
    x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
    set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
    set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    saveas(gcf,['dos_' num2str(i_natom) '.png']);
end
save dos_data.mat natom ndos normalize dos
cd ..
