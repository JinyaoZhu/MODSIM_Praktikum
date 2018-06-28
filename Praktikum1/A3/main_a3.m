% MAIN SIMULATION PROGRAM: main_a3.m
%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+
clear all;
close all;
%% System parameters (PARAMETERS CAN BE EDITED HERE)
model_name = 'sys_cl';       % model blocks
params.t_start = 0;          % simulation start time (s)
params.t_stop = 20;          % simulation end time (s)
params.t_step = 1.0;             % step time (s)
params.u_max = 0.17;         % input step height, 0.17/-0.25/0.49
params.Tm = 10;              % time constant for system 3 (s)
params.ha = 0.065;           % parameter ha for system 2
params.he = 0.085;           % parameter he for system 2
params.eps_ldf = 1e-10;      % LDF tolerance for VPG algorithm
params.var_step_size = true; % variable step size, true/false
params.h_init = 1e-3;        % initial step size (s)
params.h_min = 1e-20;        % minimum step size
params.h_max = 20;           % maximum step size
%% Simualtion
%simulation parameter
t  = params.t_start;
t_stop = params.t_stop;
h  = params.h_init;
h_hist = []; % step size history
ldf_hist = []; % LDF history
% initial values
x = 0;              % x ... system state vector
i=1;
d_state = [0;0]; % state of the simth trigger [y;u]
% simulation
timerStart = tic;
while t <= t_stop
    x_values(i,:) = x;
    [u,x,y,h,d_state,ldf] = VPG(model_name,x,t,h,d_state,...
                        params.var_step_size,params.eps_ldf,params);
    y_values(i,:) = y;
    t_values(i)   = t;
    h_hist(i) = h; % save to step size history
    u_values(i)   = u;
    ldf_hist(i) = ldf; % save to LDF history
    
    t = t + h;
    i = i+1;
    %     fprintf('sim time:%6.2f,\tstep size:%6.4f\n',t,h);
end
%% Visualisation
tElapsed = toc(timerStart)*1000;
fprintf('time elapsed:%8.3fms\n',tElapsed);
% calculate the theoretical impulse width and period (s)
Tm = params.Tm;
he = params.he;
ha = params.ha;
u_max = params.u_max;
tao_e = -Tm*log(1 - (he-ha)/(1+he-abs(u_max)));
tao_p = Tm*(log((1-ha/abs(u_max))/(1-he/abs(u_max)))-log(1-(he-ha)/(1+he-abs(u_max))));
fprintf('u_max:%6.4f,\ttau_e:%6.4fs,\ttau_p:%6.4fs\n',u_max,tao_e,tao_p);

% visualization
% all inputs and outputs
figure(1);
subplot(4,1,1);
plot(t_values,u_values,'.-')
ylabel('u');
title(sprintf('In- /Outputs, time cost:%5.3fms',tElapsed));
grid on;
subplot(4,1,2);
plot(t_values,y_values(:,1),'.-')
ylabel('e');
grid on;
subplot(4,1,3);
plot(t_values,y_values(:,2),'.-')
ylabel('y');
grid on;
subplot(4,1,4);
plot(t_values,y_values(:,3),'.-')
ylabel('y_{feedback}');
xlabel('t/s');
grid on;
% step size history and LDF history
figure(2);
subplot(2,1,1);
plot(t_values,h_hist,'.-');
ylabel('h');
grid on;
title(sprintf('step history, max.=%6.4fs, min.=%.4ds',max(h_hist),min(h_hist)));
subplot(2,1,2);
plot(t_values,ldf_hist,'.-');
ylabel('LDF');
xlabel('t/s');
grid on;
title(sprintf('LDF, max.=%.4d',max(abs(ldf_hist))));