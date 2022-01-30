function [dist] = Coss_dist (a,b)
%% vypocet cosinovy vzdalenosti dvou vektoru

dist = 1 - (dot(a,b)/(norm(a) * norm(b)));

