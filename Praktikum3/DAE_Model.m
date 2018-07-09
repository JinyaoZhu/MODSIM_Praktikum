clear all;
close all;
%=======================================================
%                     Schema
%               +--------+
%     +---------+        +----------+-----------+
%     |         +--------+          |           |
%  +--+--+          R               |           |
%  |     |                        --+--       --+--
%  | --- | us                  C1          C2
%  |     |                        --+--       --+--
%  +--+--+                          |           |
%     |                             |           |
%     +-----------------------------+-----------+
%=======================================================
%% PARAMETERS of the DAE-Model
% if using single precision
use_single = true;
% system parameters
param.C1 = 0.01; % capacitor1 [F]
param.C2 = 0.02; % capacitor2 [F]
param.R = 100; % resistor [Ohm]
param.h = 1.3e-2; % step size [s]

disp('det(J)=');
disp(det(jacobian_matrix(0,param)));
disp('cond(J)=');
disp(cond(jacobian_matrix(0,param)));
%% SIMULATION
t = 0; % start time [s]
t_end = 30; % simulation duration [s]
dt = param.h; % step size [s]
iter = uint64(0); % iteration index
N = uint64(t_end/dt); % number of sample points
% initial condition
% x = [u_C10, u_C20 ]'
x = [0;0]; 
%z = [i_C10, i_C20, u_R0, i_s0]'
z = [(us(0)/param.R)*(param.C1/(param.C1+param.C2));
    (us(0)/param.R)*(param.C2/(param.C1+param.C2));
    us(0);
    us(0)/param.R]; 
% history values for data visualization
t_hist = zeros(1,N);
u_hist = zeros(1,N);
x_hist = zeros(length(x),N);
z_hist = zeros(length(z),N);
n_iter_hist = zeros(1,N);
% wait bar handle
h_waitbar = waitbar(0,'simulation progress',...
                    'Name','simulation progress',...
                    'CreateCancelBtn',...
                    'setappdata(gcbf,''canceling'',1)');
setappdata(h_waitbar,'canceling',0);
% convert all input to single precision
if use_single
    x = single(x);
    z = single(z);
    t = single(t);
    param.C1 = single(param.C1); 
    param.C2 = single(param.C2); 
    param.R = single(param.R); 
    param.h = single(param.h); 
end
% start simulation
tStart = tic;
while t <= t_end
    iter = iter+1;
    if use_single
      u = single(us(t));    
    else
      u = us(t);    
    end
    t_hist(:,iter) = t;
    u_hist(:,iter) = u;
    x_hist(:,iter) = x;
    z_hist(:,iter) = z;
    % update
    [x,z,n_iter] = trapez(x,z,u,t,param);
    n_iter_hist(:,iter) = n_iter;
    % show progress in wait bar
    if mod(iter,1000)==0
        waitbar(t/t_end,h_waitbar,...
            sprintf('simulation time: %5.2fs / %5.2fs',t,t_end));
        % push cancel button and exit while loop
        if getappdata(h_waitbar,'canceling')
            break;
        end
    end
    t = t + dt;
end
tElapsed = toc(tStart); % get computation time [s]
delete(h_waitbar);
%% VISUALIZATION
fprintf('real time elapsed : %8.6fs\n',tElapsed);
% resize the log data
t_hist = t_hist(1,1:iter);
x_hist = x_hist(1:length(x),1:iter);
z_hist = z_hist(1:length(z),1:iter);
u_hist = u_hist(1:length(u),1:iter);
n_iter_hist = n_iter_hist(1,1:iter);
% plot voltage
figure(1);
subplot(2,1,1);
plot(t_hist,x_hist(1,:),'.-');
hold on;
plot(t_hist,x_hist(2,:),'.-');
plot(t_hist,z_hist(3,:),'.-');
plot(t_hist,u_hist(1,:),'--');
legend({'$\hat{u}_1$','$\hat{u}_2$','$\hat{u}_R$','$u_s$'},'Interpreter','latex');
xlabel('t [s]');
ylabel('u [V]');
title('Voltage','Interpreter','latex');
grid on;
% plot currents
subplot(2,1,2);
plot(t_hist,z_hist(1,:),'.-');
hold on;
plot(t_hist,z_hist(2,:),'.-');
plot(t_hist,z_hist(4,:),'-');
legend({'$\hat{i}_1$','$\hat{i}_2$','$\hat{i}_s$'},'Interpreter','latex');
xlabel('t [s]');
ylabel('i [A]');
title('Current','Interpreter','latex');
grid on;
% plot u2
u2_real_hist = u2_analytic(us(1e10), 0, t_hist, param);
figure(2);
plot(t_hist,x_hist(2,:),'.-');
hold on;
plot(t_hist,u2_real_hist(1,:),'.-');
xlabel('t [s]');
ylabel('voltage [V]');
legend({'$\hat{u}_2$','$u_2$'},'Interpreter','latex');
title({'$\hat{u}_2$ vs $u_2$'},'Interpreter','latex');
grid on;
% plot error
u2_error = u2_real_hist(1,:)-x_hist(2,:);
figure(3);
plot(t_hist,u2_error,'.-');
xlabel('t [s]');
ylabel('error [V]');
title('$u_2$ error','Interpreter','latex');
grid on;
% plot iterations of newton solver
figure(4);
plot(t_hist,n_iter_hist,'.-');
xlabel('t [s]');
ylabel('number of iterations ');
title('Iteration history of Newton solver','Interpreter','latex');
grid on;



