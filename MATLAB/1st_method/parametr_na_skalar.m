function [T] = parametr_na_skalar(X)
T = cell.empty; %prazdna bunka


%% inicializace nazvu skalaru - doindexvoat a dopsat

T(1,1) = cellstr('nazev skladby');
T(2,1) = cellstr('cesta ke skladby');
p = 2; %pocitadlo

nazvy = {'Prumer ','Median ','Rozptyl ','Smerodadnat odchylka ','1. percentil '...
    ,'99. percentil ','Mezipercentilove rozpeti ','1.kvartil ','3.kvartil '...
    ,'Mezikvartilove rozpeti '}; %bunka nazvu
%% Chromagram
for k = 1:10
    for i = 1:12
        s = [nazvy{k} 'chromagramu X radku'];
        s =strrep(s,'X',num2str(i));
        T((p+i),1) = cellstr(s);
    end
    p = p+i;    
end
%% keystrength
for k = 1:10
    for i = 1:12
        s = [nazvy{k} 'keystrength X radku'];
        s =strrep(s,'X',num2str(i));
        T((p+i),1) = cellstr(s);
    end
    p = p+i;    
end
%% Key
for i = 1:10
    s =[nazvy{i} 'Key'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Mod
for i = 1:10
    s =[nazvy{i} 'Mod'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Tonal Centroid
for k = 1:10
    for i = 1:6
        s = [nazvy{k} 'Tonal Centroid X radku'];
        s =strrep(s,'X',num2str(i));
        T((p+i),1) = cellstr(s);
    end
    p = p+i;    
end
%% Hcdf
for i = 1:10
    s =[nazvy{i} 'Hcdf'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
% %% Duration
% for i = 1:10
%     s =[nazvy{i} 'Duration'];
%     T(p+i,1) = cellstr(s);
% end
% p =p+i;
%% Rolloff
T(p+1,1) = cellstr('Rolloff');
p = p + 1;
%% Brightness
T(p+1,1) = cellstr('Brightness');
p = p + 1;
%% Roughtness
for i = 1:10
    s =[nazvy{i} 'Roughtness'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Regularity
for i = 1:10
    s =[nazvy{i} 'Regularity'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% ZRC
for i = 1:10
    s =[nazvy{i} 'ZRC'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% MCC
for k = 1:10
    for i = 1:13
        s = [nazvy{k} 'MCC X radku'];
        s =strrep(s,'X',num2str(i));
        T((p+i),1) = cellstr(s);
    end
    p = p+i;    
end
%% Belostspektra
for i = 1:10
    s =[nazvy{i} 'Belostspektra'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% RMS
for i = 1:10
    s =[nazvy{i} 'RMS'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Low Energy
T(p+1,1)= cellstr('Low Energy');
p = p + 1;
%% Fluktuace
for k = 1:10
    for i = 1:24
        s = [nazvy{k} 'Fluktuace X radku'];
        s =strrep(s,'X',num2str(i));
        T((p+i),1) = cellstr(s);
    end
    p = p+i;    
end
%% Beatspectrum
for i = 1:10
    s =[nazvy{i} 'Beatspectrum'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Events
for i = 1:10
    s =[nazvy{i} 'Events'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Events Frame
for i = 1:10
    s =[nazvy{i} 'Events Frame'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Eventdensity
for i = 1:10
    s =[nazvy{i} 'Eventdensity'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Tempo
T(p+1,1)=cellstr('Tempo');
p = p+1;
%% Pulse
for i = 1:10
    s =[nazvy{i} 'Pulse'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Metroid
for i = 1:10
    s =[nazvy{i} 'Metroid'];
    T(p+i,1) = cellstr(s);
end
p =p+i;
%% Hustota zvukovych udalosti
for i = 1:10
    s =[nazvy{i} 'Hustoty zvukovych udalosti'];
    T(p+i,1) = cellstr(s);
end
%% naplneni skalarnima hodnotama
for i = 1:size(X,2)

% nazvy
T(1,i+1)=cellstr(X(i).nazev);
T(2,i+1)=cellstr(X(i).cesta);

% %parametry
% T(3:122,i+1)=num2cell(matice_na_skalary(X(i).Chromagram));
% T(123:242,i+1)=num2cell(matice_na_skalary(X(i).Keystrength));
% T(243:252,i+1)=num2cell(matice_na_skalary(X(i).Key));
% T(253:262,i+1)=num2cell(matice_na_skalary(X(i).Mod));
% T(263:322,i+1)=num2cell(matice_na_skalary(X(i).Tonal_centroid));
% T(323:332,i+1)=num2cell(matice_na_skalary(X(i).Hcdf));
% T(333:342,i+1)=num2cell(matice_na_skalary(X(i).Duration));
% T(343,i+1)=num2cell(X(i).Rolloff);
% T(344,i+1)=num2cell(X(i).Brightness);
% T(345:354,i+1)=num2cell(matice_na_skalary(X(i).Roughtness));
% T(355:364,i+1)=num2cell(matice_na_skalary(X(i).Regularity));
% T(365:374,i+1)=num2cell(matice_na_skalary(X(i).ZRC));
% T(375:504,i+1)=num2cell(matice_na_skalary(X(i).MCC));
% T(505:514,i+1)=num2cell(matice_na_skalary(X(i).Belost_spektra));
% T(515:524,i+1)=num2cell(matice_na_skalary(X(i).RMS));
% T(525,i+1)=num2cell(X(i).Low_energy);
% T(526:765,i+1)=num2cell(matice_na_skalary(X(i).Fluktuace'));
% T(766:775,i+1)=num2cell(matice_na_skalary(X(i).Beatspectrum));
% T(776:785,i+1)=num2cell(matice_na_skalary(X(i).Events'));
% T(786:795,i+1)=num2cell(matice_na_skalary(X(i).Events_Frame'));
% T(796:805,i+1)=num2cell(matice_na_skalary(X(i).Eventdensity));
% T(806,i+1)=num2cell(X(i).Tempo);
% T(807:816,i+1)=num2cell(matice_na_skalary(X(i).pulse));
% T(817:826,i+1)=num2cell(matice_na_skalary(X(i).Metroid));
% T(827:836,i+1)=num2cell(matice_na_skalary(X(i).Hustota_zvuk_udalosti));


%parametry
T(3:122,i+1)=num2cell(matice_na_skalary(X(i).Chromagram));
T(123:242,i+1)=num2cell(matice_na_skalary(X(i).Keystrength));
T(243:252,i+1)=num2cell(matice_na_skalary(X(i).Key));
T(253:262,i+1)=num2cell(matice_na_skalary(X(i).Mod));
T(263:322,i+1)=num2cell(matice_na_skalary(X(i).Tonal_centroid));
T(323:332,i+1)=num2cell(matice_na_skalary(X(i).Hcdf));
T(333,i+1)=num2cell(X(i).Rolloff);
T(334,i+1)=num2cell(X(i).Brightness);
T(335:344,i+1)=num2cell(matice_na_skalary(X(i).Roughtness));
T(345:354,i+1)=num2cell(matice_na_skalary(X(i).Regularity));
T(355:364,i+1)=num2cell(matice_na_skalary(X(i).ZRC));
T(365:494,i+1)=num2cell(matice_na_skalary(X(i).MCC));
T(495:504,i+1)=num2cell(matice_na_skalary(X(i).Belost_spektra));
T(505:514,i+1)=num2cell(matice_na_skalary(X(i).RMS));
T(515,i+1)=num2cell(X(i).Low_energy);
T(516:755,i+1)=num2cell(matice_na_skalary(X(i).Fluktuace'));
T(756:765,i+1)=num2cell(matice_na_skalary(X(i).Beatspectrum));
T(766:775,i+1)=num2cell(matice_na_skalary(X(i).Events'));
T(776:785,i+1)=num2cell(matice_na_skalary(X(i).Events_Frame'));
T(786:795,i+1)=num2cell(matice_na_skalary(X(i).Eventdensity));
T(796,i+1)=num2cell(X(i).Tempo);
T(797:806,i+1)=num2cell(matice_na_skalary(X(i).pulse));
T(807:816,i+1)=num2cell(matice_na_skalary(X(i).Metroid));
T(817:826,i+1)=num2cell(matice_na_skalary(X(i).Hustota_zvuk_udalosti));



end
