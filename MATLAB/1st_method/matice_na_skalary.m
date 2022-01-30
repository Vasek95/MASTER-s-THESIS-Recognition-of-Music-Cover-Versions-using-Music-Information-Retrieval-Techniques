function [Y] = matice_na_skalary(A)

Y =[];
i =size(A,1);
counter = i;

%% vypocet

%mean
Y(1:i,:) =mean(A,2);

%median
Y(i+1:i+counter,:) = median(A,2);
i = i + counter;

for k = 1:counter
    B =var(A(k,:));
end%rozptyl chromagramu, v cyklu pac haze chybu v matlab fci

%rozptyl
Y(i+1:i+counter,:) = B;
i = i + counter;

%smerodatna odchylka
Y(i+1:i+counter,:) = sqrt(B);
i = i + counter;

% 1 percentile
B = prctile(A,1,2);
Y(i+1:i+counter,:) =B;
i = i + counter;

% 99 percentile
C =prctile(A,99,2);
Y(i+1:i+counter,:) = C;
i = i + counter;

%mezi percentilove rozpeti
Y(i+1:i+counter,:) = C-B;
i = i + counter;

for k = 1:counter
    row=A(k,:);
    C(k)=(median(row(find(row<median(row))))); %1. kvartil
    B(k)=(median(row(find(row>median(row)))));%3. kvartil
end

%1. kvartil
Y(i+1:i+counter,:) = C;
i = i + counter;

%3. kvartil
Y(i+1:i+counter,:) = B;
i = i + counter;

%mezi kvartilove rozpeti
Y(i+1:i+counter,:) = C-B;
i = i + counter;
