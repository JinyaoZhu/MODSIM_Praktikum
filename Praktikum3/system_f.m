%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% system_f
% INPUT x: system states
%       z: algebraic variables
%       u: system input
%       t:time
%       param: system parameters
%
% OUTPUT x_dot: derivative of system states
function x_dot = system_f(x,z,u,t,param)
C1 = param.C1;
C2 = param.C2;
x_dot = [z(1)/C1;
         z(2)/C2];
end