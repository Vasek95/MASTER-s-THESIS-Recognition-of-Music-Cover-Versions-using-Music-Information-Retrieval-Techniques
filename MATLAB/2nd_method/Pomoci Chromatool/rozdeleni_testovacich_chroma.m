function [CSM_N2,label] = rozdeleni_testovacich_chroma(X1,X2)
%% vstup
% X1 - vypocitane chromagramy prvniho stylu
% X2 - vypocitane chromagramy druheho stylu
%% vystup
% CSM_N2 - srovnani vsech chromagramu
% label - ocekavane, idelani pravdepodobnosti v matici
%% inicializace
CSM_N2 = cell.empty;
X = cell.empty;
N = 240;
label = zeros(N,N);
for k = 1:240
    if k <121
        X{k,1}= X1(k).chromagram;
    else
        X{k,1}= X2(k-120).chromagram;
    end
end
%% vypocet CSM kombinaci - 240^2
for i = 1:N
    for j = 1:N
       [~,cover_trans] = transpozice(X{i},X{j},2);
       CSM_N2{i,j} = CSM(X{i},cover_trans,1);
       if i == j
            z = mod(i,6);
            switch z
                case 0
                    label(i,j-5:j)=1;
                case 1
                    label(i,j:j+5)=1;
                case 2
                    label(i,j-1:j+4)=1;                    
                case 3
                    label(i,j-2:j+3)=1; 
                case 4
                    label(i,j-3:j+2)=1;
                case 5 
                    label(i,j-4:j+1)=1;
                    
            end
       end
    end
end



    