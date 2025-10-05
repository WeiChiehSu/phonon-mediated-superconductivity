%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot degauss vs Tc,lambda,omega_log from lambda.f90
% plot degauss vs Tc,lambda,omega_log from matdyn.f90
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 

%%%%%%%%%%%%%%INPUT PARAMETER%%%%%%%%%%%%%%%%%%%
nsig = 30;
degauss_number = 30;
name = 'V';
% material_name = 'Al bulk 111 w/o soc';
% ymin1 = 0;
% ymax1 = 5;
% ymin2 = 0;
% ymax2 = 0.8;
mustar = 0.368;
%%% color %%%
col = [1 0 0;0 1 0;0 0 1;0 1 1;1 0 1;1 1 0;0 0 0];
%%% lambda.f90 &&&
%%{
fid = fopen(['lambda.' name '.out'],'r');
degauss = zeros(degauss_number,1);
N_Ef = zeros(degauss_number,1);
for i_nsigma = 1:degauss_number
    line1 = fgetl(fid);
    degauss(i_nsigma) = str2double(line1(89:94));
    N_Ef(i_nsigma) = str2double(line1(67:76));
end
fgetl(fid);
scan_tmp = fscanf(fid,'%f %f %f',[3 degauss_number])'; fgetl(fid);
lambda = scan_tmp(:,1);
omega_log = scan_tmp(:,2);
T_c = scan_tmp(:,3);
fclose(fid);
%%% plot %%%
mkdir lambda.out
cd lambda.out
%%% lambda %%%
figure;
hold on
plot(degauss,lambda,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20); 
ylabel('lambda'); xlabel('degauss(Ry)');
title('electron-phonon coupling strength');
axis([ 0 degauss(end)*1.2 min(lambda)/1.2 max(lambda)*1.2]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
box on
saveas(gcf,['lambda' '.png']);
%%% omega_log %%%
figure;
hold on
plot(degauss,omega_log,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20); 
ylabel('\omega_{log}','interpreter','Tex'); xlabel('degauss(Ry)');
title('\omega_{log}','interpreter','Tex');
axis([ 0 degauss(end)*1.2 min(omega_log)/1.2 max(omega_log)*1.2]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
box on
saveas(gcf,['omega_log' '.png']);
%%% T_c %%%
figure;
hold on
plot(degauss,T_c,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20); 
ylabel('T_{c} (K)','interpreter','Tex'); xlabel('degauss(Ry)');
title('T_{c}','interpreter','Tex');
axis([ 0 degauss(end)*1.2 min(T_c)/1.2 max(T_c)*1.2]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
box on
saveas(gcf,['T_c' '.png']);
save data.mat degauss N_Ef lambda omega_log T_c
cd ..
%}

%%% matdyn.f90 %%%
%%{
fid = fopen('lambda','r');

fgetl(fid); fgetl(fid); fgetl(fid);
scan_tmp = fscanf(fid,'%*s %f %*s %f %*s %f %*s %*s %f ',[4 nsig])';

Broadening = scan_tmp(:,1);
lambda = scan_tmp(:,2);
dos_Ef = scan_tmp(:,3);
omega_ln = scan_tmp(:,4);
T_c = omega_ln./1.2.*exp(-1.04*(1+lambda)./(lambda-mustar*(1+0.62*lambda)));

fclose(fid);
%%% plot %%%
mkdir lambda_matdyn
cd lambda_matdyn
%%% lambda %%%
figure;
hold on
plot(Broadening,lambda,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20); 
ylabel('lambda'); xlabel('degauss(Ry)');
title('electron-phonon coupling strength');
axis([ 0 Broadening(end)*1.2 min(lambda)/1.2 max(lambda)*1.2]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
box on
saveas(gcf,['lambda' '.png']);
%%% omega_log %%%
figure;
hold on
plot(Broadening,omega_ln,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20); 
ylabel('\omega_{log}','interpreter','Tex'); xlabel('degauss(Ry)');
title('\omega_{log}','interpreter','Tex');
axis([ 0 Broadening(end)*1.2 min(omega_ln)/1.2 max(omega_ln)*1.2]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
box on
saveas(gcf,['omega_log' '.png']);
%%% T_c %%%
figure;
hold on
plot(Broadening,T_c,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20); 
ylabel('T_{c} (K)','interpreter','Tex'); xlabel('degauss(Ry)');
title('T_{c}','interpreter','Tex');
axis([ 0 Broadening(end)*1.2 min(T_c)/1.2 max(T_c)*1.2]);
set(gca,'linewidth',2);
% set(gca,'Ticklength',[0.02 0.035]);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
box on
saveas(gcf,['T_c' '.png']);
save Nb_61248_data.mat Broadening lambda dos_Ef omega_ln T_c
cd ..
%}