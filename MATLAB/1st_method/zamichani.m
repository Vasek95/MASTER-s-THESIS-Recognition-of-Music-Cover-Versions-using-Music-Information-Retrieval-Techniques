function [Y_tren, Y_tren_vyst] = zamichani(X_tren,X_tren_vyst)
%% funkce pro zamichani trenivacich vzoru
%% Vstup
% X_tren - trenovaci vzory
% X_tren_vyst - ocekavany vystup
%% Vystup
% Y_tren - zamichane trenivaci vzory
% Y_tren_vyst - zamichane ocekavane vystupy
%% inicialitzace
m=size(X_tren,1); %pocet vzoru
P  = randperm(m); %permutace = predpis pro zamichani 
%% Zamichani
Y_tren = X_tren(P,:);
Y_tren_vyst = X_tren_vyst(:,P);