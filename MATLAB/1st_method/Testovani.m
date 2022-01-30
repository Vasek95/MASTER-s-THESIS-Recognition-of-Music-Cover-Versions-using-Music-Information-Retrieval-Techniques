function [Vysledek] = Testovani(w1, w2, w3,Y_test, Y_test_vyst)
%% funkce na testovani natrenovane ANNBP site
%% vstup
% w1, w2, w3 - vahy natrenovane site
% Y_test - testovaci data
% Y_test_vyst - ocekavany vystup testu

%% Vystup site
% E_test - chyba testu u kazdeho vzoru
% prumerna_chyba_testovani - prumerna chyb pro vsechny vzory
% Vysledek - tabulka shrnuti testu

%% vypocet vystupu site


for i = 1:size(Y_test,1)
    Y_1 = tanh([1 [Y_test(i,:)]] * w1);
    Y_2 = tanh([1 [Y_1]] * w2);
    Y(:,i) = (tanh([1 [Y_2]] * w3))';
end
%% celkovy vysledek klasifikace
a = size(Y_test_vyst,2); %pocet vzoru pro testovani
klasifikace = zeros(a,1);
vyhodnoceni = cell.empty;
t = 1:a;
p = 0;
T=0;
F=0;
b = a/20;
for i=1:a
    [~,trida]=max(Y(:,i));
    klasifikace(i)=trida;
    t(1+p:b+p)=i;
    if klasifikace(i)==t(i)
        vyhodnoceni(i,1) = cellstr('True');
        T =T+1;
    else
        vyhodnoceni(i,1) = cellstr('False');
        F =F+1;
    end
    p = p+b;
end

Vysledek = cell.empty;
Vysledek(1,1) = cellstr('klasifikace testu');
Vysledek(1,2) = cellstr('vysledek klasifikace testu');
Vysledek(1,3) = cellstr('pocet spravnych (True)');
Vysledek(1,4) = cellstr('pocet spatnych (False)');
Vysledek(1,5) = cellstr('uspesne urcenych %');
Vysledek(2:a+1,1) = num2cell(klasifikace);
Vysledek(2:a+1,2) = num2cell(vyhodnoceni);
Vysledek(2,3) = num2cell(T);
Vysledek(2,4) = num2cell(F);
Vysledek(2,5) = num2cell(T/(a/100));


