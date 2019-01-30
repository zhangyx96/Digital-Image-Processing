close all;clc;clear
pic1 =imread('delighting.bmp'); %load the image
pic2 =imread('29_0.bmp'); %load the image
figure; 
imshow(pic1);  %display the origin picture
I=im2double(pic1);
I = double(pic1);
R=I(:,:,1);  
G=I(:,:,2);  
B=I(:,:,3); 
M=myhisteq(R);  
N=myhisteq(G);  
L=myhisteq(B);  
In=cat(3,M,N,L);
In_f = fft2(In);
figure;
imshow(uint8(In));
imwrite(uint8(In),'3.bmp','bmp');
