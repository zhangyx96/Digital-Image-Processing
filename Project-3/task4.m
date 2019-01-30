close all;clc;clear
pic1 =imread('Saturn.bmp'); %load the image
figure; 
imshow(pic1);  %display the origin picture
I=im2double(pic1);  %convert the uint8 to double(normalized)
[m,n,dim]=size(I);
I_f=myDFT2(I);
H = zeros([m,n])+1;
H(:,1)=0;
H(:,n)=0;
H(1:10,:)=1;
H(m-9:m,:)=1;
H = fftshift(H);
imshow(H);

IF = H.*I_f;
I_o = myIDFT2(IF);
figure;
imshow(real(I_o));
imwrite(real(I_o),'5.bmp','bmp');
