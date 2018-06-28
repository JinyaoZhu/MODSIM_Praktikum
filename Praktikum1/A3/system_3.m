%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+
% system_3 PT1-Glied
% INPUT x: old state
%       u: system input
%       t: time
%       sys_param: system parameters
%
% OUTPUT xdot: xdot
%           y: system output
function  [xdot,y] = system_3(x,u,t,sys_param)
Tm = sys_param.Tm;
% state equation (derivative)
xdot(1) = (u-x(1))/Tm;

% output equation    
y(1)= x(1);