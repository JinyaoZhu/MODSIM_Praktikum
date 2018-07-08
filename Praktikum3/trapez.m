%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% trapez
% numerical integration via trapezoid method with newton methode
% INPUT x: system states
%       z: algebraic variables
%       u: system input
%       t:time
%       sys_param: system parameters
%
% OUTPUT x_new: new system states
%        z_new: new algebraic variables
%        n_iter: number of ierations the newton solver used
function [x_new,z_new,n_iter] = trapez(x,z,u,t,sys_param)

verbose = false; % verbose model newton-solver
tol = 1e-5;

% paramter for the solver
param.C1 = sys_param.C1;
param.C2 = sys_param.C2;
param.R = sys_param.R;
param.h = sys_param.h;
param.x_k = x;
param.z_k = z;
param.u = u;
param.t = t;

% solver new x and z with newton-raphson method
[p,n_iter] = newton_solver([x;z],param,verbose,tol);
x_new = p(1:2);
z_new = p(3:6);
end