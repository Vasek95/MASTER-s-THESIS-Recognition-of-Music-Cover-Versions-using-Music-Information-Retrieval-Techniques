clc
clear all
close all

%% nacteni .CSV
A =csvread('CNN_Blues.csv',1,1);
nazvy = fopen('CNN_Blues.csv');
nazvy = fgetl(nazvy);
nazvy  = strsplit(nazvy,',');
nazvy = nazvy(2:end);
%% vykrelseni grafu
epochy = 1:size(A,1);

% accuracy
figure(1)
plot(epochy,A(:,1)*100)
hold on
plot(epochy,A(:,4)*100)
xlim([1 50])
grid on

[Max_tren_Acc, index_Max_tren_Acc] = max(A(:,1));
[Max_valid_Acc, index_Max_valid_Acc] = max(A(:,4));

xlabel('iterace [-]')
ylabel('uspesnost [%]')
legend('Trenovaci uspesnost','Validacni uspesnost')
title('Zavislost trenovaci a uspesnosti (Binary Accuary) na iteracich')

S = ['max. tren. preciznost: ',num2str(round(Max_tren_Acc*100,2)),' % v ',num2str(index_Max_tren_Acc),'. iteraci',char(10),...
     'max. valid. preciznost: ',num2str(round(Max_valid_Acc*100,2)),' % v ',num2str(index_Max_valid_Acc),'. iteraci'];
annotation('textbox',[0.15, 0.8, 0.1, 0.1], 'String', S)

% chyba
figure(2)
plot(epochy,A(:,2))
hold on
plot(epochy,A(:,5))
grid on
xlim([1 50])
[Min_tren_Loss, index_Min_tren_Loss] = min(A(:,2));
[Min_valid_Loss, index_Min_valid_Loss] = min(A(:,5));
xlabel('iterace [-]')
ylabel('chyba [-]')
legend('Trenovaci chyba','Validacni chyba')
title('Zavislost trenovaci a validacni chyby na iteracich')
S = ['min. tren. chyba: ',num2str(round(Min_tren_Loss,4)),' v ',num2str(index_Min_tren_Loss),'. iteraci',char(10),...
     'min. valid. chyba: ',num2str(round(Min_valid_Loss,4)),' v ',num2str(index_Min_valid_Loss),'. iteraci'];
annotation('textbox',[0.15, 0.8, 0.1, 0.1], 'String', S)
