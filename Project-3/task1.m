close all;clc;clear
pic1 =imread('delighting.bmp'); %load the image
pic2 =imread('29_0.bmp'); %load the image
figure;
imshow(pic1);  %display the origin picture
I=im2double(pic1);  %convert the uint8 to double(normalized)
[m,n,dim]=size(I);
I_log=log(I+1);    %ln(f(x,y))
I_f=myDFT2(I_log);   %2d DFT using the DFT function realized by myself
%the high-pass filter
rL=0.2; %
rH=4.5;
c =1;
D0=80;
xc=floor(m/2);
yc=floor(n/2);
D = zeros([m,n]);
H = zeros([m,n]);
for i=1:m
    for j=1:n
        dmin = min([i^2+j^2,i^2+(j-n)^2,(i-m)^2+j^2,(i-m)^2+(j-n)^2]);
        D(i,j)=sqrt(dmin);   %compute the required distances
        H(i,j)=(rH-rL).*(1-exp(-c*(D(i,j)^2./D0^2)))+rL; %the Gausian high-pass filter
    end
end
I_r=myIDFT2(H.*I_f);
I_r=real(I_r);
I_r=exp(I_r)-1;
I_max=max(max(max(I_r)));
I_min=min(min(min(I_r)));
FlattenedData = I_r(:)'; % 展开矩阵为一列，然后转置为一行。
MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化。
I_r = reshape(MappedFlattened, size(I_r)); % 
figure;
imshow(I_r);
imwrite(I_r,'1.bmp','bmp');