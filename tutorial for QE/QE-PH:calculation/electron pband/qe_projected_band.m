%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function use to plot band structure form *.bands.dat
% read fermi level from pw.*.scf.out
% highest occupied level (ev): : for fixed
% the Fermi energy is : for other smearing
% k path in car coordinate
% not implemented for spin-polarized
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 

%%%%%%%%%%%%%%INPUT PARAMETER%%%%%%%%%%%%%%%%%%%
name = '4layers-graphene';
material_name = 'ABCA-4layers-graphene without soc';
high_symmetry_point_name = {'\Gamma','M','K','\Gamma','interpreter','LaTex'};
hs = 4;
% atom = {'W';'Se'};
% n_atom = 1;
name_compare = { 'C' };
%name_compare = { 'C' ; 'S' };
which_atom = [ 1:4]; % which atom to plot. when use name_compare, select 2 atom
% which_orbital = [ 1 2 ]; % 1 atom : s, 2 atom : p
scale = 100;  % size of dot
ymin = -20;    % energy range [eV]
ymax = 13;
word_Ef_1 = "highest occupied level (ev):"; 
word_Ef_2 = "the Fermi energy is"; 
isSO = 0;    % 0 : w/o soc, 1 : spin polarized, 2 : w/ soc
col = [1 0 0;0 0 1;0 1 0;0 1 1;1 0 1;1 1 0;0 0 0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fermi level, from pw.*.scf.out
fid = fopen([ 'pw.' name '.scf.out' ],'r');
string_line = fgetl(fid);
abc = [];
lineCounter = 1;
while isempty(abc) == 1 
    %disp(tline)
    abc = strfind(string_line, word_Ef_2);
    if isempty(abc) == 1 
        abc = strfind(string_line, word_Ef_1);
    end
    if  isempty(abc) ~= 1      
        disp(string_line);
        %disp(lineCounter);
        tmp = textscan(string_line,'%*s %*s %*s %*s %f');
        Ef = tmp{1,1};
    end
    % Read next line
    string_line = fgetl(fid);
    lineCounter = lineCounter + 1;
end
fclose(fid);
%%%
fid = fopen(['projwfc.' name '.out'],'r');

string_line = fgetl(fid);
abc = [];
lineCounter = 1;
while isempty(abc) == 1 
    %disp(tline)
    abc = strfind(string_line, 'Problem Sizes');
    if  isempty(abc) ~= 1      
        disp(string_line);
        %disp(lineCounter);
    end
    % Read next line
    string_line = fgetl(fid);
    lineCounter = lineCounter + 1;
end
line1 = string_line;
tmp = textscan(line1,'%*s %*s %f');
natomwfc = tmp{1,1};  
line1 = fgetl(fid);
tmp = textscan(line1,'%*s %*s %f');
nbnd = tmp{1,1};
line1 = fgetl(fid);
tmp = textscan(line1,'%*s %*s %f');
nkstot = tmp{1,1};
fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid);

info = zeros(natomwfc,5);
info_name = cell(natomwfc,1);

for i = 1:natomwfc
    line1 = fgetl(fid);
    tmp = textscan(line1,'%*s %*s %*s %*s %f %s %*s %*s %f %s');
    info(i,1) = i;
    info(i,2) = tmp{1,1};
    info(i,3) = str2double(sprintf('%d',tmp{1,2}{1,1}(1,2:end)));
    info_name{i,1} = tmp{1,2}{1,1}(1,2:end);
    info(i,4) = tmp{1,3};
    info(i,5) = str2double(tmp{1,4}{1,1}(1,4));
end

projected_band = zeros(nkstot,nbnd,natomwfc);

for i = 1:nkstot
    fgetl(fid);
    fgetl(fid);
    for j = 1:nbnd
        fgetl(fid);
        ind = ftell(fid);
        line1 = fgetl(fid);
        scan_tmp = textscan(line1,'%*s %*s %f *[# %f ]',[1 1]); % it's blank line or not
        if size(scan_tmp{1,2},1) > 0 % cell format
            fseek(fid,ind,'bof');
            scan_tmp = fscanf(fid,'%*s %*s %f *[# %f ]',[2 1]);
            if size(scan_tmp,1) > 1
                projected_band(i,j,scan_tmp(2,1)) = scan_tmp(1,1);
                scan_tmp = fscanf(fid,' +%f *[# %f ]',[2 inf]); % more than one wfc
                if size(scan_tmp,1) > 1
                    for k = 1:size(scan_tmp,2)
                        projected_band(i,j,scan_tmp(2,k)) = scan_tmp(1,k);
                    end
                end
                fgetl(fid);
            end
        else
            fgetl(fid);
        end
    end
end
fclose(fid);
natom = size(unique(round(info(:,2),1)),1);
projected_band_spd = zeros(nkstot,nbnd,natom,3); % s p d
for i = 1:natom
    index_1 = find(round(info(:,2),1)==i);
    for j = 0:2 % s p d
        index_2 = find(round(info(index_1,5),1)==j);
        if isempty(index_2) ~= 1
            projected_band_spd(:,:,i,j+1) = sum(projected_band(:,:,index_2),3);
        end
    end
end

spd_name = { 's' 'p' 'd' };
load band_data.mat Ebnd kd
nk = size(Ebnd,1);
nb = size(Ebnd,2);
hk = (nk-1)/(hs-1); 
%%% plot projected band for each atom %%%
%%{
mkdir projected_band_all
cd projected_band_all
for i_which_atom = 1:size(which_atom,2)
    for i_spd = 1:3
        figure;
        hold on;
        fprintf('Plot band \n');
        plot(kd,Ebnd,'k','LineWidth',1.5);
        axis([0,kd(end),ymin,ymax]);
        box on;
        % axis square;

        %         caxis([0,0.15]);
        colorbar('vertical');
        tmp = projected_band_spd(:,:,which_atom(i_which_atom),i_spd);
        Ebnd_tmp = Ebnd(:,:);
        scatter(repmat(kd,[1 nb]),Ebnd_tmp(:),tmp(:)*scale+eps,tmp(:),'filled');
        ylabel('Energy (eV)');
        title([material_name ' ' num2str(which_atom(i_which_atom)) ' atom, ' spd_name{1,i_spd} ]);
        %plot EF
        x=[0,kd(end)];
        y=[0 0];
        plot(x,y,'k--')
        % Plot high symmetry line
        xticks([kd(1,1) kd(1,hk:hk:hk*(hs-1))]);
        xticklabels(high_symmetry_point_name);
        set(gca,'FontSize',15)
        set(gca,'Ticklength',[0 0]);
        set(gca,'linewidth',1);
        % Plot high symmetry line
        for hh=1:hs-1
            x=[kd(hk*hh) kd(hk*hh)];
            y=[ymin ymax];
            plot(x,y,'k')
        end
        saveas(gcf,[ num2str(which_atom(i_which_atom)) ' atom_ ' spd_name{1,i_spd} '.png']);
%         close
    end
end
cd ..
%close all