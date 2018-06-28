%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% u2_analytic
% INPUT u_max: step height
%       t_step: step time
%       t: current time
%       parameter: system parameters
%
% OUTPUT y: analytic solution of u2(t)
function y = u2_analytic(u_max, t_step, t, param)
C1 = param.C1;
C2 = param.C2;
R = param.R;
tau = R*(C1+C2);
y = u_max.*(1 - exp(-(t-t_step)./tau)).*(t>=t_step);
end