%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 28.06.2018                                  |
%---------------------------------------------------------+
% us
% signal source of a step signal
% INPUT  t: current time
% 
% OUTPUT y: output signal
function y = us(t)
  t_step = 0;
  us_max = 10;
  y = us_max*(t>=t_step);
end