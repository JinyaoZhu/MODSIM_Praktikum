% MODSIM Laborpraktikum, 1. Aufgabe
%
% Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%
% zu erg?nzende Codezeilen sind mit ">>> erg?nzen ...." gekennzeichnet
% Berechnung des Systems "PT1-Glied"
%
% (Hinweis: Die Struktur des Programms erlaubt eine Einbindung in
% SIMULINK als sog. S-Function; dies ist jedoch im Rahmen des
% Praktikums nicht vorgesehen!)
%---------------------------------------------------------+
%                   MODSIM GRUPPE 11                      |
% Mitglieder: Cao,Bozhi  Gao,Yue  Jia,Xuehua  Zhu,Jinyao  |
% TU Dresden, 31.05.2018                                  |
%---------------------------------------------------------+
function [sys, x0] = system_pt1( t, x, u, flag )
% Eingabe-Parameter:
% t - Zeit
% x - x(t) Zustandsvektor zum Zeitpunkt t
% u - u(t) Vektor der Eingangssignale zum Zeitpnukt t
% flag - Steuerparameter, legt fest, welche Ausgabe
% gefordert wird:
Tm = 10; % Zeitkonstante des PT1-Gliedes

x1 = x;

if flag == 0 % Ausgabe der Anfangswerte f��r den
    % Zustand auf Vektor x0
    x0 = 0;
    sys = [1,0,1,1,0,0];% diese Zeile ist nur f��r Simulink n?tig,
    % sie gilt so NUR in diesem Beispiel!
elseif abs(flag) == 1 % Ausgabe der Ableitungen von x auf
    % Vektor sys = x' = f(x(t),u(t),t)
    sys = (-x1 + u)/Tm;
elseif flag == 3 % Ausgabe der Ausgangswerte des
    % Systems auf Vektor sys:
    % sys = y = g(x(t),u(t),t)
    sys = x1;
else % bei anderen Flagwerten nichts ausgeben
    sys = [];
end