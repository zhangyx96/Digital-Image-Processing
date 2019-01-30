close all;clc;clear
pic1 =imread('delighting.bmp'); %load the image
pic2 =imread('29_0.bmp'); %load the image
figure; 
imshow(pic1);  %display the origin picture
I=im2double(pic1);  %convert the uint8 to double(normalized)
[m,n,dim]=size(I);
I_log=log(I+1);    %step1 ln(f(x,y))
I_f=fft2(I_log);   %step2 2d DFT

%the high-pass filter
rL=0.5;
rH=8;    
c=0.5;       
D0=15;
ii=floor(m); 
jj=floor(n);
for i=1:m 
    for j=1:n 
        D(i,j)=sqrt(((i-ii).^2+(j-jj).^2));   %compute the required distances
        H(i,j)=(rH-rL).*(1-exp(-(D(i,j)^2./(2*D0^2))))+rL; %
    end
end

I_r=ifft2(H.*I_f);  %
I_r=real(I_r); 
I_r=exp(I_r)-1;  
figure;
imshow((I_r));