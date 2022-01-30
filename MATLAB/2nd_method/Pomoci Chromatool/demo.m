clc
clear all 
close all
%% vypocet chromagramu a ulozeni
[Blues] = nacitani_ChromaSM('Blues',180);
save('Blues','Blues')
clear 'Blues'

[Disco] = nacitani_ChromaSM('Disco',180);
save('Disco','Disco')
clear 'Disco'

[FC] = nacitani_ChromaSM('Folk & Country',180);
save('FC','FC')
clear 'FC'

[HHPR] = nacitani_ChromaSM('Hip Hop & Rap',180);
save('HHPR','HHPR')
clear 'HHPR'

[Jazz] = nacitani_ChromaSM('Jazz',180);
save('Jazz','Jazz')
clear 'Jazz'

[Klasika] = nacitani_ChromaSM('Klasika',180);
save('Klasika','Klasika')
clear 'Klasika'

[Metal] = nacitani_ChromaSM('Metal',180);
save('Metal','Metal')
clear 'Metal'

[Pop] = nacitani_ChromaSM('Pop',180);
save('Pop','Pop')
clear 'Pop'

[Reggae] = nacitani_ChromaSM('Reggae',180);
save('Reggae','Reggae')
clear 'Reggae'

[Rock] = nacitani_ChromaSM('Rock',180);
save('Rock','Rock')
clear 'Rock'

%% Trenovaci mnozina

%1
load('Rock')
[CSM_Rock_true,CSM_Rock_false] = rozdeleni_trenovacich_chroma(Rock);
clear 'Rock'
%2
load('Reggae')
[CSM_Reggae_true,CSM_Reggae_false] = rozdeleni_trenovacich_chroma(Reggae);
clear 'Reggae'
%3
load('Metal')
[CSM_Metal_true,CSM_Metal_false] = rozdeleni_trenovacich_chroma(Metal);
clear 'Metal'
%4
load('HHPR')
[CSM_HHPR_true,CSM_HHPR_false] = rozdeleni_trenovacich_chroma(HHPR);
clear 'HHPR'
%5
load('FC')
[CSM_FC_true,CSM_FC_false] = rozdeleni_trenovacich_chroma(FC);
clear 'FC'
%6
load('Disco')
[CSM_Disco_true,CSM_Disco_false] = rozdeleni_trenovacich_chroma(Disco);
clear 'Disco'
%7
load('Blues')
[CSM_Blues_true,CSM_Blues_false] = rozdeleni_trenovacich_chroma(Blues);
clear 'Blues'

%% labely a ulozeni
%labely
Tren_Label = zeros(4200,2);
Tren_Label(1:2100,1) = 1;
Tren_Label(2101:4200,2) = 1;

%data
Tren_Data = cell.empty;
%trenovaci data covery
Tren_Data(1:300,1) = CSM_Rock_true;
Tren_Data(301:600,1) = CSM_Reggae_true;
Tren_Data(601:900,1) = CSM_Metal_true;
Tren_Data(901:1200,1) = CSM_HHPR_true;
Tren_Data(1201:1500,1) = CSM_FC_true;
Tren_Data(1501:1800,1) = CSM_Disco_true;
Tren_Data(1801:2100,1) = CSM_Blues_true;
%trenovaci data NEcovery
Tren_Data(2101:2400,1) = CSM_Rock_false;
Tren_Data(2401:2700,1) = CSM_Reggae_false;
Tren_Data(2701:3000,1) = CSM_Metal_false;
Tren_Data(3001:3300,1) = CSM_HHPR_false;
Tren_Data(3301:3600,1) = CSM_FC_false;
Tren_Data(3601:3900,1) = CSM_Disco_false;
Tren_Data(3901:4200,1) = CSM_Blues_false;

save('Tren_Data', 'Tren_Data')
save('Tren_Label', 'Tren_Label')

%% Validacni mnozina

load('Pop')
[CSM_Pop_true,CSM_Pop_false] = rozdeleni_trenovacich_chroma(Pop);
clear 'Pop'

%labely
Valid_Label = zeros(600,2);
Valid_Label(1:300,1) = 1;
Valid_Label(301:600,2) = 1;

%data
Valid_Data = cell.empty;
Valid_Data(1:300,1) =  CSM_Pop_true;
Valid_Data(301:600,1) =  CSM_Pop_false;

save('Valid_Data', 'Valid_Data')
save('Valid_Label', 'Valid_Label')