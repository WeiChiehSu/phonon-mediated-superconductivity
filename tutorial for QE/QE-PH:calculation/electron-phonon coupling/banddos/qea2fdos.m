%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eliashberg function a2F (per both spin)
% frequencies in Rydberg
% change unit from [Rydberg] to [meV] 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clear 

%%%%%%%%%%%%%%%%%%%%%%%%
name = 'V';
material_name = 'V 61872';
natom = 1;
ndos = 200;
which = 6; % which a2F to plot
nsig = 30;
nsigma = 30;
Ry_to_meV = 13.605691930242388 * 1000;
meV_to_1_over_cm = 109737.3157 / Ry_to_meV;
xmin = 0;    % energy range [meV]
xmax = 35;   
ymin = 0;    % a2F range    [modes]
ymax = 2.5;
col = [1 0 0;0 1 0;0 0 1;0 1 1;1 0 1;1 1 0;0 0 0];
if (1 + natom*3) > 7
   col_tmp = zeros(1+natom*3,3);
   col_tmp(1:7,:) = col(:,:);
   for i = 8:(1+natom*3)
       col_tmp(i,:) = rand(1,3);
   end
   col = col_tmp;
end
%%% get degauss %%%
fid = fopen(['lambda.' name '.out'],'r');
degauss = zeros(nsigma,1);
dosef = zeros(nsigma,1);
for i_degauss=1:nsigma
    line1=fgetl(fid);
    degauss(i_degauss)=str2double(line1(89:94));
    dosef(i_degauss)=str2double(line1(67:76));

end
titleee = {[ material_name ', a2F' ];['  Broadening:' num2str(degauss(which)) ' Ry' ]};
fclose(fid);
%%%
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
% column: energy, total a2F,  1 dispersion a2F, 2 dispersion a2F, etc.                                                  
fid=fopen([ 'a2F.dos' num2str(which) ],'r');

fgetl(fid);   
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);

a2F = fscanf(fid,repmat('%f ',1,2+natom*3),[2+natom*3 ndos])'; fgetl(fid);
a2F(:,1) = a2F(:,1) * Ry_to_meV;
lambda = 2 * sum(a2F(:,2)./a2F(:,1),1) * max(a2F(:,1)) / ndos;
fclose(fid);
%%% plot %%%
mkdir a2F
cd a2F
%%% total %%%
figure;
hold on
plot(a2F(:,1),a2F(:,2)','-','Color',col(1,:),'LineWidth',1.75); 
ylabel('a2F(w)'); xlabel('Energy (meV)');
legend(' total a2F ');
axis([xmin xmax ymin ymax]);
title(titleee);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
saveas(gcf,['a2F_total' '.png']);
%%% all %%%
figure;
hold on
legend_name = cell(1+natom*3,1);
for i_natom = 1:(1+natom*3)
    tmp = plot(a2F(:,1),a2F(:,1+i_natom)','-','Color',col(i_natom,:),'LineWidth',1.75); 
    tmp_2(i_natom) = tmp;
    if i_natom ==1
        legend_name{i_natom,1} = ' total a2F ';
    else
        legend_name{i_natom,1} = [ ' the ' num2str(i_natom-1) ' a2F'];
    end
end
legend(tmp_2,{char(legend_name)},'Location','northwest','NumColumns',2);
ylabel('a2F(w) (modes)'); xlabel('Energy (meV)');
axis([xmin xmax ymin ymax]);
title([  material_name ', a2F']);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
saveas(gcf,['dos_all' '.png']);

%%% mode-resolved a2F %%%
%{
for i_natom = 1:natom*3
    figure;
    hold on
    plot(a2F(:,1),a2F(:,2+i_natom)','-','Color',col(1+i_natom,:),'LineWidth',1.75); 
    legend([ ' the ' num2str(i_natom) ' a2F']);
    ylabel('a2F(w) (modes)'); xlabel('Energy (meV)');
    axis([xmin xmax ymin ymax]);
    title([  material_name ', a2F']);
    set(gca,'linewidth',2);
    % set(gca,'Ticklength',[0.02 0.035]);
    set(gca,'FontSize',15)
    set(gca,'XMinorTick','on')
    x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
    set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
    set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
%     saveas(gcf,['dos_' num2str(i_natom) '.png']);
end
%}
save a2F_data.mat which degauss dosef natom a2F lambda
%%% nsig a2F %%%
mkdir all_a2F
cd all_a2F
all_a2F = cell(1,nsig);
all_lambda = zeros(1,nsig);
for i_nsig = 1:nsig
    fid=fopen([ '../../a2F.dos' num2str(i_nsig) ],'r');

    fgetl(fid);   
    fgetl(fid);
    fgetl(fid);
    fgetl(fid);
    fgetl(fid);

    a2F = fscanf(fid,repmat('%f ',1,2+natom*3),[2+natom*3 ndos])'; fgetl(fid);
    a2F(:,1) = a2F(:,1) * Ry_to_meV;
    lambda = 2 * sum(a2F(:,2)./a2F(:,1),1) * max(a2F(:,1)) / ndos;
    all_a2F{1,i_nsig} = a2F;
    all_lambda(1,i_nsig) = lambda;
    figure;
    hold on
    plot(a2F(:,1),a2F(:,2)','-','Color',col(1,:),'LineWidth',1.75); 
    ylabel('a2F(w)'); xlabel('Energy (meV)');
    legend(' total a2F ');
    axis([xmin xmax ymin ymax]);
    titleee = [' a2F, Broadening:' num2str(degauss(i_nsig)) ' Ry' ];
    title(titleee);
    set(gca,'linewidth',2);
    % set(gca,'Ticklength',[0.02 0.035]);
    set(gca,'FontSize',15)
    set(gca,'XMinorTick','on')
    x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
    set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
    set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    saveas(gcf,['a2F_total_nsig' num2str(i_nsig) '.png']);
    close
    fclose(fid);
end

figure;
hold on
plot(degauss(1:nsig),all_lambda,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20); 
ylabel('lambda'); xlabel('degauss(Ry)');
title('electron-phonon mass enhancement parameter');
axis([ 0 degauss(nsig)*1.2 min(all_lambda)/1.2 max(all_lambda)*1.2]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
box on
saveas(gcf,['lambda' '.png']);
%%% compare %%%
%{ 
select = [ 5 10 ];
figure;
hold on
legend_name = cell(size(select,2),1);
for i = 1:size(select,2)
    tmp = plot(all_a2F{1,select(i)}(:,1),all_a2F{1,select(i)}(:,2)','-','Color',col(i,:),'LineWidth',1.75);
    tmp_2(i) = tmp;
    legend_name{i,1} = [ 'Broadening:' num2str(degauss(select(i))) ' Ry'];
end
legend(tmp_2,{char(legend_name)});
ylabel('a2F(w)'); xlabel('Energy (meV)');
axis([xmin xmax ymin ymax]);
% titleee = [' a2F, Broadening:' num2str(degauss(i_nsig)) ' Ry' ];
% title(titleee);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
x = plot([xmin xmax],[ymax ymax],'k','linewidth',2);
set(get(get(x,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
y = plot([xmax xmax],[ymin ymax],'k','linewidth',2);
set(get(get(y,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
saveas(gcf,['compare'  '.png']);
%}
cd ..
%%%
cd ..
