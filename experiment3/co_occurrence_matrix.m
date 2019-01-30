% experiment2 Canny边缘检测
clc;clear;close all;
Fig1 = imread('images/G1.bmp');  %读取原图像
Fig2 = imread('images/G2.bmp');
Fig3 = imread('images/G3.bmp');
F = Fig3;
f = rgb2gray(F);
figure;
imshow(uint8(f));
title('原图像');
[M,N] = size(f);
co_matrix = zeros(256,256);
for i = 1:M
    for j =1:N-1
        x = f(i,j)+1;
        y = f(i,j+1)+1;
        co_matrix(x,y)=co_matrix(x,y)+1;
    end
end
sum_i = sum(co_matrix(:));
co_matrix = co_matrix/sum_i;
%最大概率
max_p = max(co_matrix(:));
lin_K = 0:255;
m_r = lin_K*sum(co_matrix,2);
m_c = sum(co_matrix)*lin_K';
sigma_r = sqrt((lin_K-m_r).^2*sum(co_matrix,2));
sigma_c = sqrt(sum(co_matrix)*(lin_K'-m_c).^2);
%相关cor 对比度ct 同质性homo
cor = 0;
ct = 0;
homo = 0;
for i = 0:255
    for j = 0:255
        cor = cor+(i-m_r)*(j-m_c)*co_matrix(i+1,j+1);
        ct = ct + (i-j)^2*co_matrix(i+1,j+1);
        homo = homo+co_matrix(i+1,j+1)/(1+abs(i-j));
    end
end
cor = cor/(sigma_r*sigma_c);
%一致性unif
unif = sum(sum(co_matrix.^2));
%熵entropy
temp = co_matrix.*log2(co_matrix);
temp(isnan(temp)) = 0;
entropy = -sum(sum(temp));




        
        
