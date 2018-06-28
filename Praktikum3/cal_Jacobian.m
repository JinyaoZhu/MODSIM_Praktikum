%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% symbolic calculation of the jacobi-matrix, press run and get result
clear all;
close all;

syms u t h real;
syms C1 C2 R real;
%==========================================
x_k = sym('x_k',[2,1],'real');
x_k_1 = sym('x_k_1',[2,1],'real');

z_k = sym('z_k',[4,1],'real');
z_k_1 = sym('z_k_1',[4,1],'real');

f_k = [z_k(1)/C1;z_k(2)/C2];
f_k_1 = [z_k_1(1)/C1;z_k_1(2)/C2];

g_k_1 = [x_k_1(1)-x_k_1(2);
    z_k_1(3)+x_k_1(1)-u;
    z_k_1(3)-z_k_1(4)*R;
    z_k_1(4)-z_k_1(1)-z_k_1(2)];
%==========================================
% defining phi(p) = phi([x_k_1;z_k_1])
phi_1 = x_k_1 - x_k - (h/2)*(f_k + f_k_1);
phi_2 = g_k_1;
%==========================================
J = jacobian([phi_1;phi_2],[x_k_1;z_k_1]);
pretty(J);
det_J = det(J);
disp('det J = ');
pretty(simplify(det_J));
