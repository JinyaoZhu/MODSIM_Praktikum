%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% jacobian_matrix
% jacobi-matrix for the newton solver
% INPUT p: variable vector
%       param: parameters
%
% OUTPUT J: jacobi-matrix
function J = jacobian_matrix(p,param)
% p = [x z]'
C1 = param.C1;
C2 = param.C2;
R = param.R;
h = param.h;

J = [ 1,  0, -h/(2*C1),         0, 0,  0;
        0,  1,         0, -h/(2*C2), 0,  0;
        1, -1,         0,         0, 0,  0;
        1,  0,         0,         0, 1,  0;
        0,  0,         0,         0, 1, -R;
        0,  0,        -1,        -1, 0,  1];

end