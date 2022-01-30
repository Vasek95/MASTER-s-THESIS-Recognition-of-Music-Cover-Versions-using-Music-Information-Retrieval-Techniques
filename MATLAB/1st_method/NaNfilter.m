function [y] = NaNfilter(x)
[m,n] = size(x);
y = zeros(m,n);
for i = 1:m
    for k = 1:n
        if isnan(x(i,k))
           y(i,k) = 0;
        else
           y(i,k)=x(i,k);
        end
    end
    
end