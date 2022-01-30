function [mr1] = MR1 (D)
%% vypocet MR1 - mean rank of the first correctly identified cover
%% vstup
% D - ranking matice indexu (240x240)
%% Vystup
% mr1 - vypocitana hodnota mr1 - skalar

%reseni
[r]=size(D,1);
a = 1:6;
indexy =  zeros (1,6);
m = zeros (1,r);
for i = 1:r
    for k = 1:6
        indexy(k) = find(D(i,:)==a(k));
    end
    K = sort(indexy);
    m(i) = K(2)-1;
    if mod(i,6)==0
            a=a+6;
    end
end
mr1 = sum(m)/r;
