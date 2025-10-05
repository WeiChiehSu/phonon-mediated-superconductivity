%%% INPUT PARAMETER %%%
legend_name1 = '6-12-48'
legend_name2 = '6-16-48'
legend_name3 = '6-18-54'
legend_name4 = '6-24-48'
legend_name5 = '6-18-72'
legend_name6 = '6-18-90'
ymin =  198; 
ymax =  208;
xmax = 0.016;
%xmax = degauss(end)*1.2
col = [1 0 0;0 0 1;0 1 0;0 1 1;1 0 1;1 1 0;0 0 0];
%%%%%%%%%%%%%%%%%%%%%%%%%%
load('V_61248_data.mat')
%plot(Broadening,T_c,'.-','Color',col(3,:),'LineWidth',1.50,'MarkerSize',20);
%plot(Broadening,lambda,'.-','Color',col(3,:),'LineWidth',1.50,'MarkerSize',20);
plot(Broadening,omega_ln,'.-','Color',col(3,:),'LineWidth',1.50,'MarkerSize',20);
axis([ 0 xmax ymin ymax]);
hold on
load('V_61648_data.mat')
%plot(Broadening,T_c,'.-','Color',col(4,:),'LineWidth',1.50,'MarkerSize',20);
%plot(Broadening,lambda,'.-','Color',col(4,:),'LineWidth',1.50,'MarkerSize',20);
plot(Broadening,omega_ln,'.-','Color',col(4,:),'LineWidth',1.50,'MarkerSize',20);
axis([ 0 xmax ymin ymax]);
hold on
load('V_61854_data.mat')
%plot(Broadening,T_c,'.-','Color',col(7,:),'LineWidth',1.50,'MarkerSize',20);
%plot(Broadening,lambda,'.-','Color',col(7,:),'LineWidth',1.50,'MarkerSize',20);
plot(Broadening,omega_ln,'.-','Color',col(7,:),'LineWidth',1.50,'MarkerSize',20);
axis([ 0 xmax ymin ymax]);
hold on
load('V_62448_data.mat')
%plot(Broadening,T_c,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20);
%plot(Broadening,lambda,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20);
plot(Broadening,omega_ln,'.-','Color',col(1,:),'LineWidth',1.50,'MarkerSize',20);
axis([ 0 xmax ymin ymax]);
hold on
load('V_61872_data.mat')
%plot(Broadening,T_c,'.-','Color',col(5,:),'LineWidth',1.50,'MarkerSize',20);
%plot(Broadening,lambda,'.-','Color',col(5,:),'LineWidth',1.50,'MarkerSize',20);
plot(Broadening,omega_ln,'.-','Color',col(5,:),'LineWidth',1.50,'MarkerSize',20);
axis([ 0 xmax ymin ymax]);
hold on
load('V_61890_data.mat')
%plot(Broadening,T_c,'.-','Color',col(2,:),'LineWidth',1.50,'MarkerSize',20);
%plot(Broadening,lambda,'.-','Color',col(2,:),'LineWidth',1.50,'MarkerSize',20);
plot(Broadening,omega_ln,'.-','Color',col(2,:),'LineWidth',1.50,'MarkerSize',20);
%axis([ 0 xmax ymin ymax]);
%hold on
box on;
plot([0 0],[ymin ymax],'k--','LineWidth',1.5)
%yline(5.3,'--r');
%xline(0.014,'--r');
%ylabel('T_{c} (K)','interpreter','Tex'); xlabel('degauss(Ry)');
ylabel('\omega_{log}','interpreter','Tex'); xlabel('degauss(Ry)');
%ylabel('lambda'); xlabel('degauss(Ry)');
%title('T_{c} (K)(compare qmesh and kmesh)','interpreter','Tex');
%title('electron-phonon coupling strength(compare qmesh and kmesh)');
title('\omega_{log}(compare qmesh and kmesh)','interpreter','Tex');
set(gca,'linewidth',2);
set(gca,'FontSize',15)
set(gca,'XMinorTick','on')
%legend({legend_name1,legend_name2,legend_name3,legend_name4,legend_name5},'Location','northeast','NumColumns',1)
legend({legend_name1,legend_name2,legend_name3,legend_name4,legend_name5,legend_name6},'Location','northeast','NumColumns',1)
%saveas(gcf,['T_c(compare and kmesh3 ' '.png']);
%saveas(gcf,['T_c(compare and kmesh1' '.fig']);
saveas(gcf,['omega_log(compare qmesh and kmesh3' '.png']);
%saveas(gcf,['omega_log(compare qmesh and kmesh1' '.fig']);
%saveas(gcf,['lambda(compare qmesh and kmesh3' '.png']);
%saveas(gcf,['lambda(compare qmesh and kmesh1' '.fig']);