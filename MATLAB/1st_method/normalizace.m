function [A]=normalizace(A,dimenze)
%% vysvetleni
%dimenze = 1 - po radcich
%dimenze = 2 -  po sloupcich

%% vypocet 
K=size(A);
if ((K(1)== 1) && (K(2)>1)) || (K(1)> 1) && (K(2)==1) %je to redkovy vektor nebo sloupcovy
    A=A./max(abs(A));
elseif (K(1)> 1) && (K(2) > 1); %jedna se o matici
    switch dimenze
        case 1 %normalizuju po radcich
            for i=1:K(1)
                a = max(abs(A(i,:)));
                if a == 0
                    A(i,:)= A(i,:);
                else
                    A(i,:)=A(i,:)/a;
                end
            end             
        case 2 %normalizace po sloupcich
            for i=1:K(2)
                a = max(abs(A(:,i)));
                if a == 0   
                    A(:,i)=A(:,i);
                else
                     A(:,i)=A(:,i)/a;
                end
            end
    end
else %((K(1)==1) && (K(2)==1))
    disp('nejedna se o vektor nebo matici')
end
