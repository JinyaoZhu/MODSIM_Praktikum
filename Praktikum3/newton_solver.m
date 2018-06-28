%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% newton_solver
% Newton-Raphson-Methode finding the zero of phi(p)
% INPUT p_old: last variable vector
%       param: parameters value
%       verbose: if using debug mode
%       tol: error tolerance
%       max_iter: maximal iteration steps
%
% OUTPUT p_new: new variable vector that makes phi(p)=0
%        n_iter: number of iterations
function [p_new,n_iter] = newton_solver(p_old,param,verbose,tol,max_iter)

tol_default = 1e-6; % default eps
max_iter_default = 10; % default max iter

if nargin < 3
    verbose = false;
    tol = tol_default;
    max_iter = max_iter_default;
elseif nargin < 4
    tol = tol_default;
    max_iter = max_iter_default;
elseif nargin < 5
    max_iter = max_iter_default;
end

if(verbose)
    fprintf('Verbose Mode:\n');
    fprintf('===============Newton-Raphson===============\n');
    fprintf('%-3s | %-10s | %-10s | %-10s\n','iter','error','delta','eps');
end
n_iter = uint64(0);

while(1)
    n_iter = n_iter+1;
    phi = phi_function(p_old,param);
    J = jacobian_matrix(p_old,param);
    delta = -J\phi;
%     disp(cond(J));
    p_new = p_old + delta;
    delta_inf_norm = norm(delta,inf);
    if(verbose)
        error = norm(phi,inf);
        fprintf('%-4d | %-10.3e | %-10.3e | %-10.3e\n',n_iter,error,delta_inf_norm,tol);
    end
    if (delta_inf_norm < tol) || (max_iter <= n_iter)
        if max_iter <= n_iter
            fprintf('Solver WARN: reached max iter!\n');
        end
        break;
    end
    p_old = p_new;
end
if(verbose)
    fprintf('============================================\n\n');
end
end