%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+
% system_1 Adder
% INPUT x: old state (unneeded)
%       u: system input
%       t: time (unneeded)
%       sys_param: system parameters (unneeded)
%
% OUTPUT xdot: xdot (unneeded)
%           y: system output
function  [xdot,y] = system_1(x,u,t,sys_param)
% state equation (derivative)
xdot = 0;  % no states  ---> dummy output
% output equation    
y = u(1)-u(2);
end
