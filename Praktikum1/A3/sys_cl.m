%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+
% sys_cl topology description
% INPUT x: system state vector
%       t: current time
%       d_state: states of the Hysteresemodul
%       sys_param: parameters of all systems
%
% OUTPUT u_ext: external input in current step
%        xdot: system state vector derivative
%        y: subsystem outputs
%        d_state: new states of the Hysteresemodul
function [u_ext,xdot,y, d_state] = sys_cl(x,t,d_state,sys_param)

% u_ext = u_ext(t) modeled as internal part of the system
u_ext = sys_param.u_max*(t >= sys_param.t_step);

% static variable to save output of system_2
persistent y2;

if isempty(y2)
    y2 = 0;
end

% start block system_3 (PT1)
% exactly y2 has no effect here, system output only depends on its states
[~,y(3)] = system_3(x,y2,t,sys_param);

% system_1 (Adder)
u1(1) = u_ext;
u1(2) = y(3);
[~,y(1)] = system_1(0,u1,t,sys_param);

% system_2 (Hysteresemodul)
u2(1) = y(1);
[d_state,y(2)] = system_2(d_state,u2,t,sys_param);

% system_3 (PT1)
u3(1) = y(2);
[xdot,y(3)] = system_3(x,u3,t,sys_param);

% save system_2 output
y2 = y(2); 
end
