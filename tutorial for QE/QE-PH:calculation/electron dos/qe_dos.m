%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function use to plot band structure form *.bands.dat
% read fermi level from pw.*.scf.out
% highest occupied level (ev): : for fixed
% the Fermi energy is : for other smearing
% k path in car coordinate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 

%%%%%%%%%%%%%%INPUT PARAMETER%%%%%%%%%%%%%%%%%%%
% Ef = 7.4344;  % Fermi elvel
name = '10Nb';
material_name = 'Nb atomic layers(bulk)';
natom = 1;
xmin = -1;    % energy range 
xmax = 1;
ymin =  0;    % DOS range
ymax = 0.55;
word_Ef_1 = "highest occupied level (ev):"; 
word_Ef_2 = "the Fermi energy is"; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fermi level, from pw.*.scf.out
fid = fopen([ 'pw.' name '.nscf.out' ],'r');
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
% fid = fopen([ name '.pdos.pdos_tot'],'r');
fid = fopen([ name '.dos'],'r');
line1=fgetl(fid);               
scan_tmp = fscanf(fid,'%f %f %f',[3 inf])'; fgetl(fid); 
E_range = scan_tmp(:,1)-Ef;
%dos = scan_tmp(:,2);
dos1 = scan_tmp(:,2);
dos = dos1/(4*natom);
%dos = scan_tmp(:,2:end);

figure;
hold on;
%plot(E_range,dos(:,1),'r.-','LineWidth',3);
plot(E_range,dos,'r.-','LineWidth',2);
plot([0 0],[ymin ymax],'k--')
plot([xmin xmax],[0 0],'k')
axis([xmin,xmax,ymin,ymax]);
box on;
xlabel('Energy (eV)');
ylabel('D(E) (modes/eV)');
title([ 'total dos, ' material_name ]);
set(gca,'FontSize',15)
% set(gca,'Ticklength',[0 0]);
set(gca,'linewidth',1);
saveas(gcf,['dos1' '.png']);

save Nb_9_dos.mat E_range dos


