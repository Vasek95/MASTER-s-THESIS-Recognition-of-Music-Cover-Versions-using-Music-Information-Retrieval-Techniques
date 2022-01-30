function [mnit_n] = MNIT_n (D,n)
%% vypocet MNIT10 - Mean number of covers identified in top 10 
% tzn n = 10
%% vstup
% D - ranking matice indexu (240x240)
% n 
%% Vystup
% mnit_n - vypocitana hodnota mnit_n - skalar
%% reseni
[r]=size(D,1);
D =  D(:,2:end);
a = 1:6;
Total_numb = zeros(1,n);
Total =  zeros(1,r);
for i = 1:r
    for j = 1:n
        if ismember(D(i,j),a)
            Total_numb(j) = 1;
        end
    end
    Total(i) = sum(Total_numb);
    Total_numb = zeros(1,n);
    if mod(i,6)==0
            a=a+6;
    end
end

mnit_n = mean(Total);
