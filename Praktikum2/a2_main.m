%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 14.06.2018                                  |
%---------------------------------------------------------+
clear all;
close all;
%% PARAMETERS %%
K_L = 1; %(A/V)
i_vmax = 1; %(A)
K_sv = 0.796; %(m/As)
F_N = 63000; %(N)
Ta = 15e-3; %(s)
K_M = 1/63000; %(V/N)
b_1 = 2.39e6; %(Ns/m)
c_oil = 36.5e6; %(N/m)
m_k = 8.7; % (kg)
m_p = 260; %(kg)
m_g = m_k + m_p;
c_p = 75e6; %(N/m)
K_F = K_L*K_sv*b_1;

%% AUFGABE 2 %%
load_system('A1_Hydropulszylinder');
set_param('A1_Hydropulszylinder','maxstep','1e-3','Solver','ode45');
lin_sys = linmod('A1_Hydropulszylinder',zeros(3,1),0);
disp('################ AUFGABE 2 ################');
fprintf('Model Discretization:\n');
% compute PHI
PHI = expm(Ta*lin_sys.a);
sum_H = Ta * eye(length(PHI(:,1)));
d_sum_H = Ta;
count = 2;
% compute H iteratively
while 1
    d_sum_H = d_sum_H * lin_sys.a * Ta / count;
    sum_H = sum_H + d_sum_H;
    count = count + 1;
    if all(abs(d_sum_H(:)) <= eps), break; end
end
H = sum_H * lin_sys.b;
disp('Ta(ms):')
disp(Ta*1e3);
disp('PHI:');
disp(PHI);
disp('H:');
disp(H);
%% SIMULATION %%
load_system('A2_compare_c_d');
set_param('A2_compare_c_d','maxstep','1e-3','Solver','ode45');
u_soll = 1e-4;
sim('A2_compare_c_d');
plot(sim_result.time,sim_result.signals.values(:,1),'.-',...
     sim_result.time,sim_result.signals.values(:,2),'.-');
ylabel('F_p [N]');
xlabel('t [s]');
legend('nonlinear continuous-time','linear discrete-time');
title('Step response, u_{soll}=1e-4[V]');
grid on;
zoom on;
