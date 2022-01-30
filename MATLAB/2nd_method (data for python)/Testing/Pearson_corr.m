function [dist] = Pearson_corr (a,b)
%% Vypocet Pearsonova korelacniho koeficientu dvou vektoru
%% Vstup
% a - prvni vektor
% b - druhy vektor
%% Vystup
% dist =  vypocitana vzdalenost
%% vypocet
%prumery
ma=mean(a);
mb = mean(b);
% casti zlomku
citatel = dot((a-ma),(b-mb));
jmenovatel = (norm(a-ma))* (norm(b-mb));
%vzdalenost
v = citatel/jmenovatel;
dist = 1 - v;