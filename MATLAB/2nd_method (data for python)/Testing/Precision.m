function [P,TP] = Precision (D)
%% vypocet preciznosti
%% Vstup
% D - ranking matice indexu (240x240)
%% Vystup
% preciznost v procentech
% TP - true positive
%% reseni

TP = 0;
TN = 0;
FP = 0;
FN = 0;

a = 1:6;
for i = 1:240
    for j = 1:240
        if ismember(D(i,j),a) && j<7
            TP = TP+1;
            
        elseif ismember(D(i,j),a) && j>6
            FN = FN+1;
            
        elseif not(ismember(D(i,j),a)) && j<7
            FP = FP+1;
        else
            TN = TN+1;
        end
    end
    if mod(i,6)==0
            a=a+6;
    end
end

P = (TP/(TP+FP))*100;
