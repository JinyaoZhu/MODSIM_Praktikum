%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% system_g
% INPUT x: system states
%       z: algebraic variables
%       u: system input
%       t:time
%       param: system parameters
%
% OUTPUT y: function's value
function y = system_g(x,z,u,t,param)
R = param.R;
y = [x(1) - x(2);
    z(3) + x(1) - u;
    z(3) - z(4)*R;
    z(4) - z(1) - z(2)];
end