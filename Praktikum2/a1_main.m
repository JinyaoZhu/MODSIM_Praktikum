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
%% AUFGABE 1 %%
load_system('A1_Hydropulszylinder');
set_param('A1_Hydropulszylinder','maxstep','1e-3','Solver','ode45');
lin_sys = linmod('A1_Hydropulszylinder',zeros(3,1),0);
% simulation result
[b,a] = ss2tf(lin_sys.a,lin_sys.b,lin_sys.c,lin_sys.d);
b =b/a(4);
a = a/a(4);
lin_sys_tf = tf(b,a);

% analytic result
a1 = b_1/c_p+b_1/c_oil;
a2 = m_g/c_p;
a3 = m_g*b_1/(c_p*c_oil);

fprintf('################ AUFGABE 1 ################\n\n');
s1 = sprintf('+==================Model Verification=================+\n');
s2 = sprintf('| %-15s | %15s | %15s |\n','paramter','analytic','simulink');
s3 = sprintf('|-----------------+-----------------+-----------------|\n');
s4 = sprintf('| %-15s | %15.4d | %15.4d |\n','K_F:',K_F,b(4));
s5 = sprintf('| %-15s | %15.4d | %15.4d |\n','a1:',a1,a(3));
s6 = sprintf('| %-15s | %15.4d | %15.4d |\n','a2:',a2,a(2));
s7 = sprintf('| %-15s | %15.4d | %15.4d |\n','a3:',a3,a(1));
s8 = sprintf('+=====================================================+\n\n');
msg = [s1 s2 s3 s4 s5 s6 s7 s8];
fprintf(msg);
