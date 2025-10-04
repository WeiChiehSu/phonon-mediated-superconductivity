%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% phonon band structure: default unit [1/cm]
% change unit from [1/cm] to [meV]
% q path in car coordinate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 

%%%%%%%%%%%%%%INPUT PARAMETER%%%%%%%%%%%%%%%%%%%
name = 'V';
material_name = 'V 6187248';
natom = 1;
Ry_to_meV = 13.605691930242388 * 1000;
meV_to_1_over_cm = 109737.3157 / Ry_to_meV;
ymin = 0;    % energy range [meV]
ymax = 35;
hs = 5;
%acoustic = [ 3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid=fopen([ name '.freq'],'r');

%%READ DATA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
line1 = fgetl(fid);                 % number of kpint,band
nb = str2double(line1(13:16)); 
nk = str2double(line1(23:27));     

hk = (nk-1)/(hs-1);                     % q path
Ebnd = zeros(nk,nb);                % memory space of band
k_path = zeros(nk,3);
kd = zeros(1,nk);      
kdr = zeros(1,nk);
for ikk=1:nk
    scan_tmp = fscanf(fid,'%f %f %f',[3 1])';
        k_path(ikk,1) = scan_tmp(1,1);
        k_path(ikk,2) = scan_tmp(1,2);
        k_path(ikk,3) = scan_tmp(1,3);
        % Distance between two kpoints
        if ikk == 1       
            kdr(1,ikk)=0;
            kd(1,ikk)=0;
        else 
            kdr(1,ikk) = norm( k_path(ikk,:) - k_path(ikk-1,:) );  % Distance between two kpoints          
            kd(1,ikk) = kd(1,ikk-1) + kdr(1,ikk);   % add the distance        
        end
     scan_tmp = fscanf(fid,'%f',[1 nb]); fgetl(fid); 
     Ebnd(ikk,:) = scan_tmp(1,:);
end
Ebnd = Ebnd / meV_to_1_over_cm; %(mev)
%Ebnd = Ebnd / 33.3563; %(THz)
fclose(fid);
%%% plot %%%
figure;
hold on;

%plot(kd,Ebnd,'r','LineWidth',1.5);
for acoustic = 1:nb
      if acoustic < 4
         plot(kd,Ebnd(:,acoustic),'r','LineWidth',3);
      else
         plot(kd,Ebnd(:,acoustic),'k','LineWidth',1.5); 
      end
end      
axis([kd(1,1),kd(1,nk),ymin,ymax]);
box on;
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
% yticks([ -8 -6 -4 -2 0 2 4 6 8 10])
set(gca,'FontSize',15)
%set(gca,'Ticklength',[0 0]);
set(gca,'linewidth',2);
xlabelpoints=[kd(1,1:hk:(nk-hk))  kd(1,nk)];
for hh=1:hs
    %x=[kd(1,(1+hk*(hh-1)):hk:(hk*hh)) kd(1,(1+hk*(hh-1)):hk:(hk*hh))];
    x=[xlabelpoints(hh) xlabelpoints(hh)];    
    y=[ymin ymax];
    plot(x,y,'k','linewidth',2)
end
saveas(gcf,['phonon_band1' '.png']);
save phonon_band_data.mat Ebnd kd k_path nk
