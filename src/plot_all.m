DATA = csvread(csvfilename);

all_indices();
all_constants();

linestylle = ':';

a = zeros(1,25);
s = zeros(1,23);
e = zeros(1,17);
f= zeros(1,24);
dfdt= zeros(1,24);
t= zeros(1,1);
input= zeros(1,2);

acoff   =          0;
smcoff  =          length(a);
ecoff   = smcoff + length(s);
stoff   = ecoff  + length(e);
dfdtoff = stoff   + length(f);
tijdoff = dfdtoff+ length(dfdt);
inputoff= tijdoff+ length(t);


time = DATA(:,tijdoff+1);

% plots report

total=4;


figure(54)
hold all

subplot(total,1,1)
    plot( time,DATA(:,inputoff+1)*k_C);
title('Input signal from the neuron into the synaptic cleft')
xlabel('Time [s]')
ylabel('K^+ flux [\muM m/s]')

% subplot(total,1,1)
%     plot( time,DATA(:,acoff+flu.K_s));
% title('K^+ in SC')
% xlabel('Time [s]')
% ylabel('K_s [\muM]')

subplot(total,1,2)
plot(time,DATA(:,acoff+flu.v_k)*1000)
title('Membrane Potential of the astrocyte')
xlabel('Time [s]')
ylabel('v_k [mV]')

subplot(total,1,3)
[AX2,H12,H23] = plotyy(time,DATA(:,acoff+flu.J_BK_k)./(DATA(:,stoff+ind.R_k)*VR_pa)...
    ,time,DATA(:,smcoff+flu.J_KIR_i)/(VR_ps)...
    );
xlabel('Time [s]')
set(get(AX2(1),'Ylabel'),'String','J_{BK} [\muM/s]') 
set(get(AX2(2),'Ylabel'),'String','J_{KIR} [\muM/s]')
%legend('BK-channel','KIR-channel')
title('The contribution of the BK- and KIR-channel to K_p')

subplot(total,1,4)
plot(time,DATA(:,stoff+ind.K_p)...
     )
title('Potassium concentration in perivascular space')
xlabel('Time [s]')
ylabel('K_p  [\muM]')

%%

SMCtitle{1}='v_ coup_i';
SMCtitle{2}='Ca_ coup_i';
SMCtitle{3}='IP3_ coup_i';
SMCtitle{4}='rho_i';
SMCtitle{5}='J_ IP3_i';
SMCtitle{6}='J_ SRuptake_i';
SMCtitle{7}='J_ CICR_i';
SMCtitle{8}='J_ extrusion_i';
SMCtitle{9}='J_ leak_i';
SMCtitle{10}='J_ VOCC_i';
SMCtitle{11}='J _ NaCa_i';
SMCtitle{12}='J_ NaK_i';
SMCtitle{13}='J_ Cl_i';
SMCtitle{14}='J_ K_i';
SMCtitle{15}='Kactivation_i';
SMCtitle{16}='J_ degrad_i';

ECtitle{1}='v_ coup_j';
ECtitle{2}='Ca_ coup_j';
ECtitle{3}='IP3_ coup_j';
ECtitle{4}='rho_j';
ECtitle{5}='J_ 0_j';
ECtitle{6}='J_ IP3_j';
ECtitle{7}='J_ ERuptake_j';
ECtitle{8}='J_ CICR_j';
ECtitle{9}='J_ extrusion_j';
ECtitle{10}='J_ leak_j';
ECtitle{11}='J_ cation_j';
ECtitle{12}='J_ BKCa_j';
ECtitle{13}='J_ SKCa_j';
ECtitle{14}='J_ K_j';
ECtitle{15}='J_ R_j';
ECtitle{16}='J_ degrad_j';

figure(101)
set(gcf,'Name','SMC fluxes')
set(gcf,'Position', [24 62 1616 904],...
        'PaperPosition', [0.634517 6.34517 20.3046 15.2284]...
        );
for j = [1:3 5:16]
subplot(4,4,j)
plot(time,DATA(:,smcoff+j))
% h101(j+2) = gca();
xlabel('time in s')
ylabel(SMCtitle{j})
title(SMCtitle{j})
hold all
end

subplot(4,4,4)
plot(time,DATA(:,smcoff+flu.J_stretch_i))
xlabel('time in s')
ylabel('J stretch_i')
title('J stretch_i')

figure(102)
set(gcf,'Name','EC fluxes')
set(gcf,'Position', [24 62 1616 904],...
        'PaperPosition', [0.634517 6.34517 20.3046 15.2284]...
        );
for k = [1:3 5:16]
subplot(4,4,k)
plot(time,DATA(:,ecoff+k))
% h101(j+2) = gca();
xlabel('time in s')
ylabel(ECtitle{k}) 
title(ECtitle{k})
hold all
end

subplot(4,4,4)
plot(time,DATA(:,smcoff+flu.J_stretch_j))
ylabel('J stretch_j')
title('J stretch_j')

%% DFDT plot

figure(77)
set(gcf,'Name','DFDT')
set(gcf,'Position', [24 62 1616 904],...
        'PaperPosition', [0.634517 6.34517 20.3046 15.2284]...
        );
subplot(5,2,1)
plot(time, state(:,ind.Ca_i) )
h6(1) = gca();
xlabel('time in s')
ylabel('Ca_i in uM')
title('SMC [Ca^{2+}]')

subplot(5,2,2)
plot(time, state(:,ind.Ca_j) )
h6(2) = gca();
xlabel('time in s')
ylabel('Ca_j in uM')
title('EC [Ca^{2+}]')

subplot(5,2,3)
plot(time, state(:,ind.I_i) )
h6(8) = gca();
xlabel('time in s')
ylabel('I_i in uM')
title('SMC [IP_{3}]')

subplot(5,2,4)
plot(time, state(:,ind.I_j) )
h6(9) = gca();
xlabel('time in s')
ylabel('I_j in uM')
title('EC [IP_{3}]')

subplot(5,2,5)
plot(time, state(:,ind.s_i) )
h6(3) = gca();
xlabel('time in s')
ylabel('s_i in uM')
title('SR [Ca^{2+}]')

subplot(5,2,6)
plot(time, state(:,ind.s_j) )
h6(4) = gca();
xlabel('time in s')
ylabel('s_j in uM')
title('ER [Ca^{2+}]')

subplot(5,2,7)
plot(time, state(:,ind.v_i) )
h6(5) = gca();
xlabel('time in s')
ylabel('v_i in mV')
title('SMC membrane voltage')

subplot(5,2,8)
plot(time, state(:,ind.v_j) )
h6(6) = gca();
xlabel('time in s')
ylabel('v_j in mV')
title('EC membrane voltage')

subplot(5,2,9)
plot(time, state(:,ind.w_i) )
h6(7) = gca();
xlabel('time in s')
ylabel('w_i [-]')
title('open probability K^+ channel')


linkaxes(h6, 'x');

%% plot myosin crossbridge model

MCtitle{1}='[M]';
MCtitle{2}='[Mp]';
MCtitle{3}='[AMp]';
MCtitle{4}='[AM]';

figure
set(gcf,'Name','Myosin model and radius')

subplot(3,2,1)
plot(time,DATA(:,smcoff+flu.M))
xlabel('Time')
ylabel('Fraction [-]')
title(MCtitle{1})

for j = 2:4
    subplot(3,2,j)
    plot(time,state(:,ind.Mp+j-2))
    xlabel('Time')
    ylabel('Fraction [-]')
    title(MCtitle{j})
end

subplot(3,2,5)
plot(time,state(:,ind.AMp)+state(:,ind.AM))
xlabel('Time')
ylabel('Fraction [-]')
title(' F_r')

subplot(3,2,6)
plot(time,1e6*state(:,ind.R))
xlabel('Time')
ylabel('Radius in uM')
title('Radius')

%% Potassium plots

% figure;
% subplot(2,2,1)
% plot(time,state(:,ind.K_i))
% title('K^+ in SMC')
% subplot(2,2,2)
% plot(time,DATA(:,smcoff+flu.J_KIR_i))
% title('KIR channel outflux')
% subplot(2,2,3)
% plot(time,-DATA(:,smcoff+flu.J_K_i))
% title('J K_i outflux')
% subplot(2,2,4)
% plot(time,DATA(:,smcoff+flu.J_NaK_i))
% title('J NaK_i influx')