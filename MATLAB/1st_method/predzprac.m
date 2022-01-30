function [parametry] = predzprac(filename,fs_2,t)
%% popis funkce
% nacte dany zvukovy soubor, predzpracuje a preda fci pro extrahovani
% parametru
%% nacteni hudebniho mp3 souboru
[x,fs] = audioread(filename);

%% mono
if size(x,2)>1 %zjistim jestli uz neni mono
    y = (x(:,1)+x(:,2))/2;
else
    y = x;
end
%% ulozeni do WAV souboru
wavfilename = strrep(filename,'.mp3','.wav'); %vymena koncovky => ulozeni jako wav
if fs>fs_2
    [up,down]=rat(fs_2/fs);
    y = resample(y,up,down,10);% pri downsamplinu pouziji anti-aliasinf 10 radu.
elseif fs<22050
    [up,down]=rat(fs/fs_2);
    y = resample(y,up,down);
else
    fs_2 = fs;
end
%% prvni t sekund
if length(y) < t*fs_2
    y0 = zeros(t*fs_2,1);
    y0(1:length(y),1) = y;
    y = y0;
elseif t == 0;
    if length(y)>((9*60)*fs_2)
        t9 = 9*60;
        y = y(1:(t9*fs_2));
    end
else
     y = y(1:t*fs_2,1);
end
y = y/max(abs(y)); %normalizace aby nepeakoval
audiowrite(wavfilename,y,fs_2) %ulozeno jako wav, fs_2, 16bit, mono

%% nacteni WAV souboru a extrahovani parametru
[parametry]=extrahovani_parametru(wavfilename); %extrahovani parametru

nazev = strsplit(wavfilename,'/'); %rozdeleni lomitka
parametry.nazev = nazev(length(nazev));
parametry.cesta = filename; %pojmenovani sady parametru
%% odstraneni souboru WAV a promenych x,y
delete (wavfilename)



