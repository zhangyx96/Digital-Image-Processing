function Io = myhisteq(A)
[m,n] = size(A);
H = zeros([1,256]); %the gray histogram vector
for i=1:m
    for j=1:n
        H(A(i,j)+1)=H(A(i,j)+1)+1;%the coresponding value plus 1
    end
end
H = H/(m*n);%normalize the histogram
S=zeros(1,256); %Sk is the cumulative histogram
for k=1:256
    S(k)=sum(H(1:k));
end
S = 255*S; %S is the new gray histogram of I
Io=zeros([m,n]);
for i=1:m
    for j=1:n
        Io(i,j)=S(A(i,j)+1); %mapping
    end
end
