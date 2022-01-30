function [OTI,cover_trans] = transpozice (O,C,metoda)
%% sjednoceni stejne toniny podle Serra - OTI metoda
% metoda pdole "Transposing Croma Representation to a Common Key"
% Joan Serra, Emilia Gomez and Perfecto Herrera
%% vstup
% O - chromagram originalu
% C - chromagram coveru
% metoda - 1 = globalni_chroma, 2 = hruba sila
%% vystup
%OTI - cislo o kolik se ma funkce cicrshift rotovat
%cover_trans - rotovany chromagram o OTI
%% vypocet OTI - optimal transpose index - Globalni chromagramy
if metoda  == 1
    dim = 2;
    global_original=(sum(O,dim))/(max(sum(O,dim)));
    global_cover=(sum(C,dim))/(max(sum(C,dim)));
    posun=length(global_cover);
    circ_indx = zeros(1,posun);
    for i = 1:posun
        circ_indx(i)=dot(global_original,circshift(global_cover,i));
    end
    [~,OTI]=max(circ_indx);

end
%% metoda brute force
if metoda == 2
    posun = size(C,1);
    Dist = zeros(1,posun);
    for i = 1:posun
        Dist(i)=norm(O-circshift(C,i),'fro');
    end
    [~,OTI]=min(Dist);
end
%% transpozice
cover_trans = circshift(C,OTI);
