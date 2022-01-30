clear all
clc
close all
%% Vypocet parametru pro kazdy styl
% [X_Blues] = nacitani_MIR('Blues',44100,180);
% save('X_Blues','X_Blues')
% clear 'X_Blues'
% 
% [X_Disco] = nacitani_MIR('Disco',44100,180);
% save('X_Disco','X_Disco')
% clear 'X_Disco'
% 
% [X_FC] = nacitani_MIR('Folk & Country',44100,180); 
% save('X_FC','X_FC')
% clear 'X_FC'
% 
% [X_HHPR] = nacitani_MIR('Hip Hop & Rap',44100,180);
% save('X_HHPR','X_HHPR')
% clear 'X_HHPR'
% 
% [X_Klasika] = nacitani_MIR('Klasika',44100,180);
% save('X_Klasika','X_Klasika')
% clear 'X_Klasika'
% 
% [X_Metal] = nacitani_MIR('Metal',44100,180);
% save('X_Metal','X_Metal')
% clear 'X_Metal'
% 
% [X_Pop] = nacitani_MIR('Pop',44100,180);
% save('X_Pop','X_Pop')
% clear 'X_Pop'
% 
% [X_Reggae] = nacitani_MIR('Reggae',44100,180);
% save('X_Reggae','X_Reggae')
% clear 'X_Reggae'
% 
% [X_Rock] = nacitani_MIR('Rock',44100,180);
% save('X_Rock','X_Rock')
% clear 'X_Rock'
% 
% [X_Jazz] = nacitani_MIR('Jazz',44100,180);
% save('X_Jazz','X_Jazz')
% clear 'X_Jazz'
%% Trenovaci mnozina
% vypocitani cover CSM s labelem [1,0] = 300 pro kazdy styl
%1
load('X_Rock')
[CSM_Rock_true,CSM_Rock_false] = rozdeleni_tren_chroma(X_Rock);
clear 'X_Rock'
%2
load('X_Reggae')
[CSM_Reggae_true,CSM_Reggae_false] = rozdeleni_tren_chroma(X_Reggae);
clear 'X_Reggae'
%3
load('X_Pop')
[CSM_Pop_true,CSM_Pop_false] = rozdeleni_tren_chroma(X_Pop);
clear 'X_Pop'
%4
load('X_HHPR')
[CSM_HHPR_true,CSM_HHPR_false] = rozdeleni_tren_chroma(X_HHPR);
clear 'X_HHPR'
%5
load('X_FC')
[CSM_FC_true,CSM_FC_false] = rozdeleni_tren_chroma(X_FC);
clear 'X_FC'
%6
load('X_Disco')
[CSM_Disco_true,CSM_Disco_false] = rozdeleni_tren_chroma(X_Disco);
clear 'X_Disco'
%7
load('X_Blues')
[CSM_Blues_true,CSM_Blues_false] = rozdeleni_tren_chroma(X_Blues);
clear 'X_Blues'

% spojeni vsech sytlu a vytvoreni labelu

%labely
Tren_Label = zeros(4200,2);
Tren_Label(1:2100,1) = 1;
Tren_Label(2101:4200,2) = 1;

%data
Tren_Data = cell.empty;
%trenovaci data covery
Tren_Data(1:300,1) = CSM_Rock_true;
Tren_Data(301:600,1) = CSM_Reggae_true;
Tren_Data(601:900,1) = CSM_Pop_true;
Tren_Data(901:1200,1) = CSM_HHPR_true;
Tren_Data(1201:1500,1) = CSM_FC_true;
Tren_Data(1501:1800,1) = CSM_Disco_true;
Tren_Data(1801:2100,1) = CSM_Blues_true;
%trenovaci data NEcovery
Tren_Data(2101:2400,1) = CSM_Rock_false;
Tren_Data(2401:2700,1) = CSM_Reggae_false;
Tren_Data(2701:3000,1) = CSM_Pop_false;
Tren_Data(3001:3300,1) = CSM_HHPR_false;
Tren_Data(3301:3600,1) = CSM_FC_false;
Tren_Data(3601:3900,1) = CSM_Disco_false;
Tren_Data(3901:4200,1) = CSM_Blues_false;

save('Tren_Data', 'Tren_Data')
save('Tren_Label', 'Tren_Label')

%% Validacni mnozina

load('X_Metal')
[CSM_Metal_true,CSM_Metal_false] = rozdeleni_tren_chroma(X_Metal);
clear 'X_Metal'

%labely
Valid_Label = zeros(600,2);
Valid_Label(1:300,1) = 1;
Valid_Label(301:600,2) = 1;

%data
Valid_Data = cell.empty;
Valid_Data(1:300,1) =  CSM_Metal_true;
Valid_Data(301:600,1) =  CSM_Metal_false;

save('Valid_Data', 'Valid_Data')
save('Valid_Label', 'Valid_Label')

%% Trenovaci mnozina

load('X_Jazz')
load('X_Klasika')
[CSM_test_mtx,label_test_mtx] = rozdeleni_test_chroma(X_Jazz,X_Klasika);
clear 'X_Jazz'
clear 'X_Klasika'

%uprava na "vektory" matic a labelu
Test_Data = reshape(CSM_test_mtx,[],1);
Test_Label_vec = reshape(label_test_mtx,[],1);
Test_Label_vec(:,2) = abs(Test_Label_vec-1); 

% rozdeleni na party - Test_Data = 12GB - nemam disk na prenos MAC-Win (max
% 4GB) - kvuli formatu disku
Test_Data_Part_1 = Test_Data(1:14400,:);
Test_Data_Part_2 = Test_Data(14401:28800,:);
Test_Data_Part_3 = Test_Data(28801:43200,:);
Test_Data_Part_4 = Test_Data(43201:57600,:);

Test_Label_vec_Part_1 = Test_Label_vec(1:14400,:);
Test_Label_vec_Part_2 = Test_Label_vec(14401:28800,:);
Test_Label_vec_Part_3 = Test_Label_vec(28801:43200,:);
Test_Label_vec_Part_4 = Test_Label_vec(43201:57600,:);
% ulozeni
save('Test_Data_Part_1','Test_Data_Part_1','-v7.3')
save('Test_Data_Part_2','Test_Data_Part_2','-v7.3')
save('Test_Data_Part_3','Test_Data_Part_3','-v7.3')
save('Test_Data_Part_4','Test_Data_Part_4','-v7.3')

save('Test_Label_vec_Part_1','Test_Label_vec_Part_1')
save('Test_Label_vec_Part_2','Test_Label_vec_Part_2')
save('Test_Label_vec_Part_3','Test_Label_vec_Part_3')
save('Test_Label_vec_Part_4','Test_Label_vec_Part_4')



