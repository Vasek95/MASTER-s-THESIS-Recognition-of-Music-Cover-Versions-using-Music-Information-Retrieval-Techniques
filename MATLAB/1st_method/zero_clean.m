function [B,N,indx]=zero_clean(A,nazvy,dimenze)
%% vstup
%A - matice funkci odstrani zbytecne parametry = parametry plne nul u vsech vzroku
%nazvy - vektor nazvu
%dimenze = 1 - po radcich
%dimenze = 2 -  po sloupcich 
%% vystup
%B - vystup bez nul
%indx - indexy, parametru, ktere byly odstraneny
%% dimenze
if dimenze == 2
    A = A';
end

%% vypocet
k = 0; %krok odectu radku
for i = 1:size(A,1) 
    if mean(A(i,:)) < 0.00001
        k = k+1;
        indx(k) = i;
    else
        B(i-k,:)=A(i,:);
        N(i-k,:)=nazvy(i,:);
    end
end
%% zpetan transformace pokud je dimenze taková
if dimenze == 2
    B = B';
end