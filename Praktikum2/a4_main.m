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

%% AUFGABE 4 %%
% linearization
load_system('A1_Hydropulszylinder');
set_param('A1_Hydropulszylinder','maxstep','1e-3','Solver','ode45');
lin_sys = linmod('A1_Hydropulszylinder',zeros(3,1),0);
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

% controller parameter
K_I = 0.31;


%% SIMULATION %%
% u_soll = 0.1
figure(1);
u_max = 0.1;
load_system('A4_control_loop_nlin_c_model');
set_param('A4_control_loop_nlin_c_model','maxstep','1e-3','Solver','ode45');
sim('A4_control_loop_nlin_c_model');
plot(sim_result.time,sim_result.signals.values(:,1),'.-',...
     sim_result.time,sim_result.signals.values(:,2),'.-',...
     sim_result.time,sim_result.signals.values(:,3),'.-');
ylabel('u_{soll} / u_{meas} [V]');
xlabel('t [s]');
legend('input','linear discrete-time model','nonlinear continuous-time model');
title('Step response,u_{soll}=0.1');
grid on;
zoom on;
% u_soll = 0.5
figure(2);
u_max = 0.5;
sim('A4_control_loop_nlin_c_model');
plot(sim_result.time,sim_result.signals.values(:,1),'.-',...
     sim_result.time,sim_result.signals.values(:,2),'.-',...
     sim_result.time,sim_result.signals.values(:,3),'.-');
ylabel('u_{soll} / u_{meas} [V]');
xlabel('t [s]');
legend('input','linear discrete-time model','nonlinear continuous-time model');
title('Step response,u_{soll}=0.5');
grid on;
zoom on;
% u_soll = 0.8
figure(3);
u_max = 0.8;
sim('A4_control_loop_nlin_c_model');
plot(sim_result.time,sim_result.signals.values(:,1),'.-',...
     sim_result.time,sim_result.signals.values(:,2),'.-',...
     sim_result.time,sim_result.signals.values(:,3),'.-');
ylabel('u_{soll} / u_{meas} [V]');
xlabel('t [s]');
legend('input','linear discrete-time model','nonlinear continuous-time model');
title('Step response,u_{soll}=0.8');
grid on;
zoom on;
