function F = myDFT2(I)
[M,N,dim]=size(I);
m = 0:M-1;
n = 0:N-1;
p = 0:M-1;
k = 0:N-1;
WN_r=exp(-1i*2*pi/N);
WN_c=exp(-1i*2*pi/M);
nk_r=n'*k;
mp_c=m'*p;
WNnk_r=WN_r.^nk_r;
WNmp_c=WN_c.^mp_c;
F = zeros([M,N,dim]);
for i=1:M
    for k=1:dim
        F(i,:,k) = I(i,:,k)*WNnk_r;
    end
end
for j=1:N
    for k=1:dim
        F(:,j,k) = WNmp_c*F(:,j,k);
    end
end


