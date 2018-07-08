%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% phi_function
% INPUT p: variable vector
%       param: parameters
%
% OUTPUT y: function's value
function y = phi_function(p,param)
x_k = param.x_k;
z_k = param.z_k;
u = param.u;
t = param.t;
h = param.h;

x_k_1 = p(1:2); % x_{k+1}
z_k_1 = p(3:6); % z_{k+1}
y(1:2,1) = x_k_1 - x_k - (h/2)*(system_f(x_k,z_k,u,t,param)+system_f(x_k_1,z_k_1,u,t,param));
y(3:6,1) = system_g(x_k_1,z_k_1,u,t,param);
end