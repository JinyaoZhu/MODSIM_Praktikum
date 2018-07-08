% MODSIM Laborpraktikum, 1. Aufgabe
% Prof. K. Janschek, Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%
% main_a1.m - Realisierung der VPG-Methode mit Fehlersch?tzung
% f��r PT1-Glied
% zu erg?nzende Codezeilen sind mit ">>> erg?nzen ...." und ...��gekennzeichnet
%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+
clear all % L?sche Arbeitsspeicher
close all;
Tm = 10; % Konstante des PT1, [s]
h = 0.1; % Schrittweite, (s)
t0 = 0; % Integrationsbeginn, [s]
tf = 300; % Integrationsende, [s]
t = []; % Zeitwerte f��r Plot [s]
d = []; % Fehler-Sch?tzwerte
u = []; % Stellwerte u(t)
y = []; % Ausgangswerte y(t)
ys = []; % Soll-Ausgangswerte y_soll(t)
h_hist = []; % step size history
step_time = 1.0;
% Initialisierung
[dum,x(1)] = system_pt1([],[],[],0);
d(1) = 0;
% Integration nach VPG-Methode
ti = t0;
i = 1;
tStart = tic;
while ti <= tf
% Berechnung des Stellwertes
u(i) = u_step(ti);
% Berechnung des Soll-Ausgangswertes
ys(i) = u(i)*(1-exp(-(ti-step_time)/Tm));
% Berechnung des Ausgangswertes
y(i) = system_pt1( ti , x(i) , u(i) , 3); 
% Berechnung der Koeffizienten f��r VPG-Methode
k1 = system_pt1( ti , x(i) , u_step(ti) , 1);
k2 = system_pt1( ti+h/2 , x(i)+k1*h/2 , u_step(ti+h/2) , 1); 
k3 = system_pt1( ti+h , x(i)-h*k1+2*h*k2 , u_step(ti+h) , 1); 
% Wichtiger Hinweis: Die Parameter bei den Aufrufen von system_pt1(...)
% m��ssen unter Beachtung von jeweiligen Zeitpunkten bestimmt werden!
% Berechnung des Zustands-Sch?tzwertes x(ti+h)
x(i+1) = x(i)+h*k2;
% Berechnung der LDF Fehlerabsch?tzung d(ti+h)
d(i+1) = h*(k1-2*k2+k3)/6;

t(i) = ti; % Zeitwert f��r Plot speichern
ti = ti + h; % Zeitvariable um einen Schritt erh?hen
i = i + 1; % Index inkrementieren
end
tElapsed = toc(tStart)*1000; % get computation time
fprintf('time elapsed:%8.6fms\n',tElapsed);

d = d(1:end-1);
result = [t;d];
% Anzeige der Ergebnisse
figure(1);
subplot(2,1,1); plot(t,u,'.-'); title(sprintf('Eingang PT1-Glied, time cost:%5.3fms',tElapsed));zoom on;grid on;
subplot(2,1,2); plot(t,y,'.-'); title('Ausgang PT1-Glied');zoom on;grid on;
xlabel('Zeit, s');
figure(2);
subplot(2,1,1); plot(t,y-ys,'.-'); title('GDF berechnet');zoom on;grid on;
tit=sprintf('LDF geschaetzt: max. Betrag = %g',max(abs(d)));
subplot(2,1,2); plot(t,d,'.-'); title(tit);zoom on;grid on;
xlabel('Zeit, s');
