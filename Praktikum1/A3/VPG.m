%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+
% VPG Verbesserte Polygonzugmethode 
% INPUT model_name: name of the model we simulate
%       x: old state
%       t: simulation time
%       h: old step size
%       d_state: states of the Hysteresemodul, here we need this in oder to 
%                clear the memory of the Hysteresemodul when we using
%                variable step size algorithm
%       use_var_step: using variable step size or not (true/false)
%       eps: LDF tolerance for variable step size algorithm
%       sys_param: parameters of all systems
%
% OUTPUT u: system input
%        x: new state
%        y: system output
%        h: new step size
%        d_state: new states of the Hysteresemodul
%        ldf: local discrete error
function [u, x, y, h, d_state, ldf] = VPG(model_name,x,t,h,d_state,use_var_step,sys_param,eps)

if isempty(sys_param.h_min)||isempty(sys_param.h_max)
    h_min = 1e-20;
    h_max = 20;
else
    h_min = sys_param.h_min;
    h_max = sys_param.h_max;
end

% if no epsilon given use default value
if nargin == 7  
  eps = 1e-10;
end

good_result = false;
d_state_raw = d_state;

while ~good_result
    d_state = d_state_raw; % reset simth trigger states
    % derivatives @ t, t+h/2, t+h
    [u, k1, y, d_state] = feval(model_name, x, t ,d_state,sys_param);
    [~, k2, ~, d_state] = feval(model_name, x+h*k1/2, t+h/2,d_state,sys_param);
    [~, k3, ~, d_state] = feval(model_name, x-h*k1+2*h*k2, t+h,d_state,sys_param);
    
    % calculate LDF
    d = h*(k1-2*k2+k3)/6;
    d_norm = abs(d);
    
    % whether using variable step size
    if ~use_var_step
        break;
    end

    % calculate new step size
    if d_norm ~= 0
        h_new = h*(eps/d_norm)^(1/3);
         % constrain step size
        h_new = max(h_min, min(h_max,h_new));
        if h_new > 2*h
            h = h_new;
            good_result = true;
        elseif h_new <= h
            h = 0.75*h_new;
            good_result = false;
        else
            good_result = true;
        end
    else
        good_result = true;
    end
end

% update
x = x + h*k2;
ldf = d;
end
