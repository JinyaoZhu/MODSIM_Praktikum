%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 14.06.2018                                  |
%---------------------------------------------------------+
function x_oil_dot =  Servoventil(input)
in_vec = num2cell(input);
[F_z,i_v] = in_vec{:};
F_N = 63000; %(N)
K_sv = 0.796; %m/As
A = 1 - sign(i_v)*F_z/F_N;
if A<=0
    x_oil_dot = 0;
else
    x_oil_dot = i_v*K_sv*sqrt(A);
end
end