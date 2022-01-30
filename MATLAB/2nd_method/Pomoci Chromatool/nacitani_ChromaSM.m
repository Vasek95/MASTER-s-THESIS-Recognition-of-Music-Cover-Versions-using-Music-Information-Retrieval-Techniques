function [X] = nacitani_ChromaSM(styl,t)
%% zadavani cesty slozky
myFolder = '/Volumes/1.6TB/Databáze/slozka';
myFolder = strrep(myFolder,'slozka',styl);

%% testovani jestli je to cesta nebo soubor

if ~isdir(myFolder) %jedna se o soubor
  disp('Jedna se o jeden soubor ne o slozku');
  X = predzprac(styl,fs_2); %jednali se o jeden mp3 soubor
  return;
  
else %jedna se o slozku
    filePattern = fullfile(myFolder, '*.mp3'); %beru vsechny soubory co konci mp3
    theFiles = dir(filePattern);
    for k = 1 : length(theFiles)
      baseFileName = theFiles(k).name;
      fullFileName = fullfile(myFolder, baseFileName);
      fprintf(1, 'Ted nacitam %s\n', fullFileName);
      X(k) = predzprac_ChromaSM(fullFileName,t);
    end
end