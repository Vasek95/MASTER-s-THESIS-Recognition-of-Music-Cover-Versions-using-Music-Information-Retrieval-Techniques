function [Y_tren, Y_tren_vyst,Y_valid, Y_valid_vyst, Y_test, Y_test_vyst] = rozdeleni(X_data,tren,valid,test)
% funkce rozdeli vstupni data na trenovaci a testovaci mnozinu
%% vstup
%X_data - vstupni parametry
%tren - pocet trenovacich vzoru
%test - pocet testovacich vzoru
%% vystup
%Y_tren - matice pro trenovani
%Y_tren_vyst - ocekavany vystup trenovani
%Y_test - matice pro testovani
%Y_test_vyst - ocekavany vystup testovani
%% test na spravny vstup
if (tren + test + valid) ~= size(X_data,1)
    disp('Soucet skladeb trenovaci a testovaci mnoziny musi byt roven celkovemu poctu skladeb');
elseif mod(tren,20) ~= 0 && mod(valid,20) ~= 0 && mod(test,20) ~= 0   
    disp('pocet skladeb pro trenovani, validaci a testovani musi byt delitelny cislem 20');
else
    %vytvoreni prazdnych matic pro rozdeleni
    k =size(X_data,2); % pocet parametru
    Y_tren = zeros(tren,k);
    Y_tren_vyst = ones(20,tren)*-1;
    Y_valid = zeros(valid,k);
    Y_valid_vyst = ones(20,valid)*-1;
    Y_test = zeros(test,k);
    Y_test_vyst = ones(20,test)*-1;
    %iteratory
    i=0; %prochazi daty
    j=0; %pro trenovaci mnozinu
    m=0; %pro validacni mnozinu
    n=0; %pro testovaci mnozinu
    q=1; %pro preskoceni na dalsi tridu
    %vypocet posuvniku
    a = tren/20;
    b = valid/20;
    c = test/20;
    while i<size(X_data,1)
        %data k trenovani
        Y_tren(1+j:a+j,:) = X_data(1+i:a+i,:);
        Y_tren_vyst(q,1+j:a+j) = 1;
        
        %data k validaci
        Y_valid(1+m:b+m,:) = X_data((6*q)-b-c+1:6*q-c,:);
        Y_valid_vyst(q,1+m:b+m) = 1;
   
        %data k testovani
        Y_test(1+n:c+n,:) = X_data((6*q)-c+1:6*q,:);
        Y_test_vyst(q,1+n:c+n) = 1;
    
    %indexy
    i = i+6;
    j=j+a;
    m = m+b;
    n=n+c;
    q=q+1;
    end 
end



