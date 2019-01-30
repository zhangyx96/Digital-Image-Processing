function H = myfftshift(A)
[m,n,d]=size(A);
H = zeros([m,n,d]);
for i =1:m
    for j = 1:n
        for k = 1:d
            H(i,j,k)=A(i,j,k)*(-1)^(i+j);
        end
    end
end
        