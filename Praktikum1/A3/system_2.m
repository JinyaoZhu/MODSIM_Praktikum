%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+
% system_2 Hysteresemodul
% INPUT x: old state x(1)=y, x(2)=u
%       u: system input
%       t: time
%       sys_param: system parameters
%
% OUTPUT x: new state
%        y: system output
function  [x,y] = system_2(x,u,t,sys_param)

ha = sys_param.ha;
he = sys_param.he;

% calculate difference of input
d_u = u - x(2);

% output equation according last input and output
if x(1) == 0
    if d_u < 0 && u<-he
        y = -1;
    elseif d_u > 0 && u>he
        y = 1;
    else
        y = x(1);
    end
elseif x(1) == 1
    if d_u<0 && u<ha
        y = 0;
    else
        y = x(1);
    end
elseif x(1) == -1
    if d_u>0 && u>-ha
        y = 0;
    else
        y = x(1);
    end
end

% save current input and output
x(1) = y;
x(2) = u;

end
