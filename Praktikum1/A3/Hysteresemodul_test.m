%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+

% testing the system block 2, Hysteresemodul
clear;
close all;

params.ha = 0.065;   % parameter ha for system 2
params.he = 0.085;   % parameter he for system 2

t = 0:0.001:10;
u = 0.5*sin(t);
x = [0;0];

for i = 1:length(t)
    [x,y(i)] = system_2(x,u(i),t(i),params);
end

figure(1);
plot(t,u,t,y); grid on;
legend('u','y');
xlabel('t/s');
ylabel('y');
title('Hysteresemodul Test');