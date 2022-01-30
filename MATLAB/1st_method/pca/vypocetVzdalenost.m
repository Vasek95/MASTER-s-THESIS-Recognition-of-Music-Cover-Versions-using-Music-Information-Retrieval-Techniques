function []=vypocetVzdalenost(feat_matrix,nazev,kat)
%% Vstup
% feat_matrix - parametry od mRMR 
% nazev styliu pro graf
% do kolikati kategorii byly data kategorizovány
%% Vystup
% graf skaldeb ve vektorovem prostoru

%% Inicializace
Y =feat_matrix;
nazvy = cell.empty; %bunka pro nazvy bodu
p = 1; %pomocny parametr pro naplneni nazvu
v = 10; %velikost pisma v popisu bodu grafu 
for i = 1:size(Y,1)
    if (i==1) || (mod(i,6) == 1)
        s = ['O', num2str(p)];
        p = p+1;
        nazvy(i,1) = cellstr(s);
        k=i;
    else
            s = ['C^',num2str(i-k),num2str(p-1),];
            nazvy(i,1) = cellstr(s);
    end
end %naplneni nazvu
%% normalizace feature matice
normalized_matrix = normalizeMatrix(feat_matrix);
%% PCA
D = pdist(normalized_matrix);
Z = squareform(D);
[P, ~] = cmdscale(Z);
%% normalizace bodu v rovine do rozsahu -1 do 1
P = P + abs(min(P(:))); 
P = P ./ max(P(:));
%% vykresleni grafu
barvy = {'r','g','b','k','m'};
figure(1)    
for i =1:20
    if i < 6
        symbol = strcat('.' ,barvy(i));
        barva = barvy(i);
        plot(P((i*6-5),1),P((i*6-5),2),char(symbol),'MarkerSize',60,'LineWidth',1,'Color', char(barva))
        hold on
        plot(P(i*6-4:i*6,1),P(i*6-4:i*6,2),char(symbol),'MarkerSize',40,'LineWidth',1)
        text(P((i*6-5):i*6,1)+0.010,P((i*6-5):i*6,2)+0.010,nazvy((i*6-5):i*6),'FontSize',v)
        hold on
  
    elseif i > 5 && i < 11
        symbol = strcat('x' ,barvy(i-5));
        barva = barvy(i-5);
        plot(P((i*6-5),1),P((i*6-5),2),char(symbol),'MarkerSize',15,'LineWidth',1,'Color', char(barva))
        hold on
        plot(P(i*6-4:i*6,1),P(i*6-4:i*6,2),char(symbol),'MarkerSize',10,'LineWidth',1)
        text(P((i*6-5):i*6,1)+0.010,P((i*6-5):i*6,2)+0.010,nazvy((i*6-5):i*6),'FontSize',v)
        hold on
    elseif i > 10 && i < 16
        symbol = strcat('o' ,barvy(i-10));
        barva = barvy(i-10);
        plot(P((i*6-5),1),P((i*6-5),2),char(symbol),'MarkerSize',15,'LineWidth',1,'Color', char(barva))
        hold on
        plot(P(i*6-4:i*6,1),P(i*6-4:i*6,2),char(symbol),'MarkerSize',10,'LineWidth',1)
        text(P((i*6-5):i*6,1)+0.010,P((i*6-5):i*6,2)+0.010,nazvy((i*6-5):i*6),'FontSize',v)
        hold on
    else
        symbol = strcat('s' ,barvy(i-15));
        barva = barvy(i-15);
        plot(P((i*6-5),1),P((i*6-5),2),char(symbol),'MarkerSize',15,'LineWidth',1,'Color', char(barva))
        hold on
        plot(P(i*6-4:i*6,1),P(i*6-4:i*6,2),char(symbol),'MarkerSize',10,'LineWidth',1)
        text(P((i*6-5):i*6,1)+0.010,P((i*6-5):i*6,2)+0.010,nazvy((i*6-5):i*6),'FontSize',v)
        hold on
    end
    
end  
xlim([min(P(:,1))-0.05 max(P(:,1))+0.05])
ylim([min(P(:,2))-0.05 max(P(:,2))+0.05])
xlabel('Normalizovana vzdalenost')
ylabel('Normalizovana vzdalenost')
nazev = ['Vzdalenosti vsech skladeb pro styl ', nazev];
title(nazev,'FontSize',14)
S = ['pocet kategorickych stavu: ', num2str(kat),char(10),...
     'pocet parametru mRMR: ',num2str(size(Y,2))];
annotation('textbox',[0.2, 0.8, 0.1, 0.1], 'String', S)
hold on
grid on
daspect([1 1 1])


