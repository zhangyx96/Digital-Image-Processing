%experiment2 Canny边缘检测
clc;clear;close all;
Fig1 = imread('Lena.jpg');  %读取原图像
Fig2 = imread('house.bmp');
Fig3 = imread('brain.bmp');
f1 = im2double(rgb2gray(Fig1));
f2 = im2double(rgb2gray(Fig2));
f3 = im2double(rgb2gray(Fig3));
f = f3;
figure;
imshow(f);
title('原图像');
[M,N] = size(f);
%Step1 高斯滤波
m = 25; %滑窗尺寸
n = m;
pad_length = (m-1)/2;
gaussKernel = fspecial('gaussian', [m,n], 5);
f_pad = mypad(f,pad_length); %边缘填充
fs = zeros([M,N]);
for i = 1:M
    for j = 1:N
        Subwin = f_pad(i:i+m-1,j:j+n-1);
        G = Subwin.*gaussKernel;
        fs(i,j) = sum(G(:));
    end
end
figure;
imshow(fs);
title('高斯平滑');
%Step2 计算梯度强度和方向 Sobel算子
Sx = [-1,0,1;-2,0,2;-1,0,1];
Sy = [1,2,1;0,0,0;-1,-2,-1];
G = zeros([M,N]);  %梯度矩阵
Gx = zeros([M,N]);
Gy = zeros([M,N]);
theta = zeros([M,N]); %角度矩阵
D = zeros([M,N]);%方向矩阵 [|0,\1,/2,--3]
fs_pad = zeros([M+2,N+2]); %边缘填充，求边缘梯度
fs_pad(2:M+1,2:N+1) = fs;
fs_pad(1,2:N+1) = fs(2,:);
fs_pad(M+2,2:N+1) = fs(M-1,:);
fs_pad(:,1) = fs_pad(:,3);
fs_pad(:,N+2) = fs_pad(:,N);
for  i =1:M
    for j =1:N
        Subwin = fs_pad(i:i+2,j:j+2);
        Gx(i,j) = sum(sum(Subwin.*Sx));
        Gy(i,j) = sum(sum(Subwin.*Sy));
        G(i,j) = sqrt(Gx(i,j)^2+Gy(i,j)^2);
        if Gx(i,j) == 0
            Gx(i,j) = 0.0000001;
        end
        theta(i,j)=atand(Gy(i,j)/Gx(i,j));
        if (theta(i,j)>=-90 && theta(i,j)<-67.5)
            D(i,j) = 0;
        elseif (theta(i,j)>=-67.5 && theta(i,j)<-22.5)
            D(i,j) = 1;
        elseif (theta(i,j)>=-22.5 && theta(i,j)<22.5)
            D(i,j) = 3;
        elseif (theta(i,j)>=22.5 && theta(i,j)<67.5)
            D(i,j) = 2;
        else
            D(i,j) = 0;
        end
        
    end
end
G_max = max(max(G));
if G_max ~= 0
    G = G / G_max;
end
%Step3.4 非极大值抑制+双阈值检测
Gs = zeros([M,N]);
h = imhist(G,64); %通过直方图统计来确定高阈值
per = 0.715;
HT = find(cumsum(h) > per*M*N,1,'first') / 64; %高阈值
LT = 0.8*HT;
for i = 2:M-1
    for j = 2:N-1
        switch D(i,j) %方向矩阵 [|0,\1,/2,--3]
            case 0
                if G(i,j)>G(i-1,j) && G(i,j)>G(i+1,j)
                    if G(i,j)>HT
                        Gs(i,j)=1;
                    elseif G(i,j)>LT
                        Gs(i,j)=0.5;
                    else
                        Gs(i,j)=0;
                    end
                end
            case 1
                if G(i,j)>G(i-1,j-1) && G(i,j)>G(i+1,j+1)
                    if G(i,j)>HT
                        Gs(i,j)=1;
                    elseif G(i,j)>LT
                        Gs(i,j)=0.5;
                    else
                        Gs(i,j)=0;
                    end
                end
            case 2
                if G(i,j)>G(i-1,j+1) && G(i,j)>G(i+1,j-1)
                    if G(i,j)>HT
                        Gs(i,j)=1;
                    elseif G(i,j)>LT
                        Gs(i,j)=0.5;
                    else
                        Gs(i,j)=0;
                    end
                end
            case 3
                if G(i,j)>G(i,j-1) && G(i,j)>G(i,j+1)
                    if G(i,j)>HT
                        Gs(i,j)=1;
                    elseif G(i,j)>LT
                        Gs(i,j)=0.5;
                    else
                        Gs(i,j)=0;
                    end
                end
        end
    end
end
figure;
imshow(Gs);
title('双阈值检测')
%Step5 抑制孤立低阈值点
Gk = Gs;
for i = 2:M-1
    for j = 2:N-1
        if Gk(i,j)==0.5 %如果检测到弱边缘点
            if sum(sum(Gk(i-1:i+1,j-1:j+1)==1))>0
                Gk(i,j)=1;
            else
                Gk(i,j)=0;
            end            
        end
    end
end
figure;
imshow(Gk);
title('最终效果');
imwrite(Gk,'Result.bmp','bmp');
