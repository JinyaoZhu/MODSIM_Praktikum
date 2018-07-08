%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 14.06.2018                                  |
%---------------------------------------------------------+
function i_v = Leistungsstufe(u)
i_vmax = 1; %(A)
K_L = 1; %(A/V)

if u>1
    i_v = i_vmax;
elseif u>=-1 && u<=1
    i_v = K_L*u;
else
    i_v = -i_vmax;
end
end