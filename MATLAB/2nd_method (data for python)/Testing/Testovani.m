clc
clear all

%% popis
% skript nacte vystupy site ulozene v souborech .mat a spoji je do matice A
% pote probehne vypocet vzdalenosti pomoci pearsonovy korelace
% nasledne je vystup serazen a vypocitana uspenost
% jsou pouzity oba modely - nejmnesi valid a nejmensi tren. chyba
% vypocita ranking pomoci max_pravdepodobnost, min_cos a min_pearsoncorr
%% nacteni vystupu z natrenivane CNN (4 casti)
%sit s nejmensi validacni chybou po predlozeni testovacich dat 
pred_1_min = load('Test_Pred_1_min.mat');
pred_2_min = load('Test_Pred_2_min.mat');
pred_3_min = load('Test_Pred_3_min.mat');
pred_4_min = load('Test_Pred_4_min.mat');
%sit na konci trenovani po predlozeni testovacich dat 
pred_1_end = load('Test_Pred_1_end.mat');
pred_2_end = load('Test_Pred_2_end.mat');
pred_3_end = load('Test_Pred_3_end.mat');
pred_4_end = load('Test_Pred_4_end.mat');

d = length(pred_1_min.foo);

Eval_1_min = load('Evaluace_1_min.mat');
Eval_2_min = load('Evaluace_2_min.mat');
Eval_3_min = load('Evaluace_3_min.mat');
Eval_4_min = load('Evaluace_4_min.mat');

Eval_1_end = load('Evaluace_1_end.mat');
Eval_2_end = load('Evaluace_2_end.mat');
Eval_3_end = load('Evaluace_3_end.mat');
Eval_4_end = load('Evaluace_4_end.mat');
%% prumerna evaluacni chyba a uspesnost
los_min = (Eval_1_min.foo(1)+Eval_2_min.foo(1)+Eval_3_min.foo(1)+Eval_4_min.foo(1))/4;
ACC_min = ((Eval_1_min.foo(2)+Eval_2_min.foo(2)+Eval_3_min.foo(2)+Eval_4_min.foo(2))/4)*100;
los_end = (Eval_1_end.foo(1)+Eval_2_end.foo(1)+Eval_3_end.foo(1)+Eval_4_end.foo(1))/4;
ACC_end = ((Eval_1_end.foo(2)+Eval_2_end.foo(2)+Eval_3_end.foo(2)+Eval_4_end.foo(2))/4)*100;
list = {'Eval_1_min','Eval_2_min','Eval_3_min','Eval_4_min',...
    'Eval_1_end','Eval_2_end','Eval_3_end','Eval_4_end'};
clear(list{:})
%% uprava na matici 240x240
% min validacni chyba
V_min= zeros(1,d*4);
V_min(1:d) = pred_1_min.foo(:,1);
V_min(d+1:2*d) = pred_2_min.foo(:,1);
V_min(2*d+1:3*d) = pred_3_min.foo(:,1);
V_min(3*d+1:end) = pred_4_min.foo(:,1);
% konec testovani
V_end= zeros(1,d*4);
V_end(1:d) = pred_1_end.foo(:,1);
V_end(d+1:2*d) = pred_2_end.foo(:,1);
V_end(2*d+1:3*d) = pred_3_end.foo(:,1);
V_end(3*d+1:end) = pred_4_end.foo(:,1);


A_min = reshape(V_min,240,240);
A_min = A_min';
A_end = reshape(V_end,240,240);
A_end = A_end';
list = {'pred_1_min','pred_2_min','pred_3_min','pred_4_min',...
    'pred_1_end','pred_2_end','pred_3_end','pred_4_end',...
    };
clear(list{:})
%% laboratorni data -  pro otestovani ze vyhodnocovaci system funguje
% load('Test.mat');
% A_ideal = label_test_mtx;
%A = abs(A - (rand(240,240)*0.5));

%% Vypocet vzdalenosti
p = size(A_min,1); % pocet vzoru
B_min_coss = zeros(p,p); %matice vzdalenosti
B_min_corr = zeros(p,p); %matice vzdalenosti
B_end_coss = zeros(p,p);
B_end_corr = zeros(p,p);
for i  = 1:p
    for j = 1:p
         %cos
         B_min_coss(i,j)= Coss_dist(A_min(i,:),A_min(j,:));
         B_end_coss(i,j)= Coss_dist(A_end(i,:),A_end(j,:));

         %cor
         B_min_corr(i,j)= Pearson_corr(A_min(i,:),A_min(j,:));
         B_end_corr(i,j)= Pearson_corr(A_end(i,:),A_end(j,:));
    end
end
%% serazeni od nejmensoch po nejvesti
% zajimaji nas index -  arg sort ascending
% na prvnich pozicich indx(1,:) jsou indexy prvnich n coververze

%sit s min valid chybou
[val_min_P, indx_min_P]=sort(A_min,2,'descend');
[val_min_cos,indx_min_coss]=sort(B_min_coss,2);
[val_min_corr,indx_min_corr]=sort(B_min_corr,2);

%sit na konci trenovani
[val_end_P, indx_end_P]=sort(A_end,2,'descend');
[val_end_coss,indx_end_coss]=sort(B_end_coss,2);
[val_end_corr,indx_end_corr]=sort(B_end_corr,2);

%% vyhodnoceni

%sit s min valid chybou
VYSLEDEK_MIN =  cell.empty;
VYSLEDEK_MIN{1,1} = 'Minimalni valid. chyba';
VYSLEDEK_MIN{1,2} = 'MNIT5';
VYSLEDEK_MIN{1,3} = 'MAP';
VYSLEDEK_MIN{1,4} = 'Prec';
VYSLEDEK_MIN{1,5} = 'MR1';
VYSLEDEK_MIN{1,6} = 'Pocet spravne urcenych';
% Pravdepodbnost
VYSLEDEK_MIN{2,1} = 'max_P';
VYSLEDEK_MIN{2,2} = MNIT_n(indx_min_P,5);
VYSLEDEK_MIN{2,3} = MAP(indx_min_P);
[VYSLEDEK_MIN{2,4},VYSLEDEK_MIN{2,6}] = Precision(indx_min_P);
VYSLEDEK_MIN{2,5} = MR1(indx_min_P);
% Cos
VYSLEDEK_MIN{3,1} = 'min_coss';
VYSLEDEK_MIN{3,2} = MNIT_n(indx_min_coss,5);
VYSLEDEK_MIN{3,3} = MAP(indx_min_coss);
[VYSLEDEK_MIN{3,4},VYSLEDEK_MIN{3,6}] = Precision(indx_min_coss);
VYSLEDEK_MIN{3,5} = MR1(indx_min_coss);
% Corr
VYSLEDEK_MIN{4,1} = 'min_corr';
VYSLEDEK_MIN{4,2} = MNIT_n(indx_min_corr,5);
VYSLEDEK_MIN{4,3} = MAP(indx_min_corr);
[VYSLEDEK_MIN{4,4},VYSLEDEK_MIN{4,6}] = Precision(indx_min_corr);
VYSLEDEK_MIN{4,5} = MR1(indx_min_corr);

%sit s min valid chybou
VYSLEDEK_END =  cell.empty;
VYSLEDEK_END{1,1} = 'Konecny stav site';
VYSLEDEK_END{1,2} = 'MNIT5';
VYSLEDEK_END{1,3} = 'MAP';
VYSLEDEK_END{1,4} = 'Prec';
VYSLEDEK_END{1,5} = 'MR1';
VYSLEDEK_END{1,6} = 'Pocet spravne urcenych';
% Pravdepodbnost
VYSLEDEK_END{2,1} = 'max_P';
VYSLEDEK_END{2,2} = MNIT_n(indx_end_P,5);
VYSLEDEK_END{2,3} = MAP(indx_end_P);
[VYSLEDEK_END{2,4},VYSLEDEK_END{2,6}] = Precision(indx_end_P);
VYSLEDEK_END{2,5} = MR1(indx_end_P);
% Cos
VYSLEDEK_END{3,1} = 'min_coss';
VYSLEDEK_END{3,2} = MNIT_n(indx_end_coss,5);
VYSLEDEK_END{3,3} = MAP(indx_end_coss);
[VYSLEDEK_END{3,4},VYSLEDEK_END{3,6}] = Precision(indx_end_coss);
VYSLEDEK_END{3,5} = MR1(indx_end_coss);
% Corr
VYSLEDEK_END{4,1} = 'min_corr';
VYSLEDEK_END{4,2} = MNIT_n(indx_end_corr,5);
VYSLEDEK_END{4,3} = MAP(indx_end_corr);
[VYSLEDEK_END{4,4},VYSLEDEK_END{4,6}] = Precision(indx_end_corr);
VYSLEDEK_END{4,5} = MR1(indx_end_corr);






