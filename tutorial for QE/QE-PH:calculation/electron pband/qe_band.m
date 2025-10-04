%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function use to plot band structure form *.bands.dat
% read fermi level from pw.*.scf.out
% highest occupied level (ev): : for fixed
% the Fermi energy is : for other smearing
% k path in car coordinate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 

%%%%%%%%%%%%%%INPUT PARAMETER%%%%%%%%%%%%%%%%%%%
%Ef = 7.4344;  % Fermi elvel
name = 'vdw-df3-opt1';
material_name = 'ABCA-4layers-graphene without soc';
high_symmetry_point_name = {'\Gamma','M','K','\Gamma','interpreter','LaTex'};
hs = 4;
ymin = -3.5;    % energy range [eV]
ymax = 3.5;
word_Ef_1 = "highest occupied level (ev):"; 
word_Ef_2 = "the Fermi energy is"; 
%%% for wannier purpose %%%
iwannier = 0;
dis_froz_min = -7.5;
dis_froz_max = 3.5;
num_bands    = 24;
exclude_bands_lowest = 4;
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
fid = fopen([ name '.bands.dat'],'r');

line1=fgetl(fid);                 % number of kpint,band
tmp = textscan(line1,'%*s %*s %d %*s %*s %d %*s');
nk = tmp{1,2};     
nb = tmp{1,1};  

hk = (nk-1)/(hs-1);                     % k mesh
Ebnd = zeros(nk,nb);                % memory space of band
k_path_car = zeros(nk,3);
kd = zeros(1,nk);      
kdr = zeros(1,nk);
for ikk=1:nk
    scan_tmp = fscanf(fid,'%f %f %f',[3 1])'; fgetl(fid); 
        k_path_car(ikk,1:3) = scan_tmp(1,1:3);
        % Distance between two kpoints
        if ikk == 1       
            kdr(1,ikk)=0;
            kd(1,ikk)=0;
        else 
            kdr(1,ikk) = norm( k_path_car(ikk,:) - k_path_car(ikk-1,:) );  % Distance between two kpoints          
            kd(1,ikk) = kd(1,ikk-1) + kdr(1,ikk);   % add the distance        
        end
     scan_tmp = fscanf(fid,'%f',[1 nb]); fgetl(fid); 
     Ebnd(ikk,:) = scan_tmp(1,:);
end
Ebnd = Ebnd - Ef;
fclose(fid);
%%% plot %%%
figure;
hold on;

fprintf('Plot band \n');
plot(kd,Ebnd,'k','LineWidth',2);
axis([0,kd(end),ymin,ymax]);
box on;
% axis square;
ylabel('Energy (eV)');
title(material_name);

x=[0,kd(end)];
y=[0 0];
plot(x,y,'k--')
% Plot high symmetry line
xticks([kd(1,1) kd(1,(hk:hk:hk*(hs-1))+1)]);
xticklabels(high_symmetry_point_name);
set(gca,'FontSize',15)
set(gca,'Ticklength',[0 0]);
set(gca,'linewidth',1);
for hh=1:hs-1
    x=[kd(hk*hh+1) kd(hk*hh+1)];
    y=[ymin ymax];
    plot(x,y,'k')
end
saveas(gcf,['band11' '.png']);
if iwannier == 1
   plot([kd(1) kd(end)],[dis_froz_min dis_froz_min],'g','LineWidth',2); 
   plot([kd(1) kd(end)],[dis_froz_max dis_froz_max],'g','LineWidth',2); 
   plot(kd,Ebnd(:,num_bands+exclude_bands_lowest),'r','LineWidth',2); 
   saveas(gcf,['band_wannier' '.png']);
   disp(dis_froz_min + Ef);
   disp(dis_froz_max + Ef);
end
% close all
 save band_data.mat Ebnd kd k_path_car
