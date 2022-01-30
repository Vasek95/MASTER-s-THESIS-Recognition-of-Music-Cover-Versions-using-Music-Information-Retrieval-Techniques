function [map] = MAP (D)
%% vypocet MAP - Mean Average Precison
%% Vstup
% D - ranking matice indexu (240x240)
% C - pocet coververzi, ktere hledame (6)
% https://towardsdatascience.com/breaking-down-mean-average-precision-map-ae462f623a52
%% VYSTUP 
% map - hodnota map
%% reseni
r=size(D,1);
a = 1:6;
AP = zeros(r,1); %average precision - prumerna preciznost
radek = zeros(1,6);
p = 0;
for i = 1:r
    for j = 1:6
       if ismember(D(i,j),a)
            radek(j) = 1;
            p = p+(sum(radek)/j);
       end  
    end
    AP(i) = p/6;
    %nulovani
    radek = zeros(1,6);
    p = 0;
    if mod(i,6)==0
            a=a+6;
    end
end
map = mean(AP);


