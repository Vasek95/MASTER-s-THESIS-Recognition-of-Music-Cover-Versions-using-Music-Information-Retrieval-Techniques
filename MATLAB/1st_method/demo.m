%% Extrahovani parametru
% vytsupem cell statistickych parametru pro dany styl
% vypocet pro jeden styl trva cca jeden den :(
%Pop_Mir = nacitani('Pop',44100,180); 
%Pop = parametr_na_skalar(Pop_Mir); 
%Pop(3:end,2:end)= num2cell(NaNfilter(cell2mat(Pop(3:end,2:end)))); %filtrace NaNu
%cell2csv('Pop.csv',Pop) %takto ulozim do CSV - muze to cist excel atd a ma to 700kb
%save('Pop','Pop_Mir','Pop')

%% uvodni cistka
clc
clear all
close all
%% nacteni ulozenych dat
% pokud uz mame parametry vypocitane, tak staci nacist a vyhodnotit. ?>
% mRMR a ML
styl  = 'Reggae';
pripona = '.mat';
cesta = '/Volumes/1.6TB/Databáze/Prvni_Metoda/Statistika/styl';
cesta = strrep(cesta,'styl',strcat(styl,pripona));
X = load(cesta);
X = getfield(X,styl);
%% inicializace parametru
%mRMR
k=20; %pocet parametru pro mRMR 180 parametru mìlo i 50% uspech
n = 0; % normalizace dat pred mRMR
t = [1 0.75 0.5 0.25 0.1 0.05 0.025 -0.025 -0.05 -0.1 -0.25 -0.5 -0.75 -1];%tresholdy pro kategorizaci
%t = [1 0.5 -0.5 -1];
kat = size(t,2)+1; %do kolika kategorir
var = 1; %varianta mRMR
dim = 1; %dimenze kategorizace

%zasumovani dalsich vzoru
p = 100; %kolik pridam zasumnenych vzoru 20
s = 0.06; %jak moc sumu 0.06
%% mRMR
[Y,Y_nazvy,indx_ods,tridy] = mRMR(X,k,n,var,dim,t,kat);
%% TOP 10
Y_best_ten = Y_nazvy(1:10,1);
%cell2csv([styl,'.txt'],Y_best_ten)
%cell2csv([styl,'.csv'],Y_nazvy)
%% normalizace dat
if n ~= 1
    Y = normalizace(Y,2);
end
%% zobrazeni PCA
figure(1)
vypocetVzdalenost(Y,styl,kat)

%% rozdeleni dat
[Y_tren, Y_tren_vyst,Y_valid, Y_valid_vyst, Y_test, Y_test_vyst] = rozdeleni(Y,80,20,20);
%% rozsireni trenovacich vzoru pomoci sumu
[Y_tren, Y_tren_vyst] = add_noise(Y_tren, Y_tren_vyst,p, s);
%% Trenovani (BP - ANN)
%inicializace
neuronCountLayer1 = 2*k; %pocet neuronu v prvni skryte vrstve
neuronCountLayer2 = k; %pocet neuronu v druhe skryte vrstve
Ec_stop = 0.001; %max chyba - ukonceni
maxIter = 200;  %max iteraci - ukonceni 
alpha = 0.002;  %koeficient uceni 0.002
M = 0.8;        %momentum <0;1> 0.9

%spusteni site
[E_tren,E_valid,w1,w2,w3,w1_min,w2_min,w3_min] = BPNN(Y_tren,Y_tren_vyst,Y_valid,Y_valid_vyst,neuronCountLayer1,neuronCountLayer2,Ec_stop,maxIter,alpha,M,styl,p,s);
%% Test
%w1_min...  vahy kde byla minimalni chyba testivani
[Min_chyba,Min_chyba_iter] = min(E_valid);
Vysledek_min_Valid =  Testovani(w1_min,w2_min,w3_min,Y_test,Y_test_vyst);
Vysledek_end =  Testovani(w1,w2,w3,Y_test,Y_test_vyst);
Accuracy_min_Valid = Vysledek_min_Valid{2,5};
Accuracy_end = Vysledek_end{2,5};
%% Data pro Class Learner
Class_Learner = zeros(120,k+1);
Class_Learner(:,1) = tridy;
Class_Learner(:,2:end) = Y;
