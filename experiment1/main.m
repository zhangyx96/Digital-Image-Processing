clc;clear;close all;
Fig = imread('board-orig.bmp');  %读取原图像
[m,n]=size(Fig);  %原图像尺寸
figure(1);
imshow(Fig),title('原始图像');
F = im2double(Fig); %转成double类型
%% 添加椒盐噪声
F1 = F;
n1 = rand([m,n]);  %生成[0,1]的随机数矩阵
for i=1:m
    for j =1:n
        if(n1(i,j)<0.25)  %生成25%的椒盐噪声
            F1(i,j)=randi([0,1]); %椒噪声和盐噪声概率相等
        end
    end
end
figure;
imshow(F1),title('添加了25%椒盐噪声的图像');
imwrite(F1,'添加了25%椒盐噪声的图像.bmp','bmp');
%% 添加高斯噪声
F2 = F;
mean = 20;  %均值
sigma = sqrt(400); %标准差
n2 = rand([m,n]);  %生成[0,1]的随机数矩阵
for i=1:m
    for j =1:n
        if(n2(i,j)<0.2)
            F2(i,j)=normrnd(mean,sigma)/255+F2(i,j);  %添加高斯噪声
            F2(i,j) = max(0,F2(i,j));
            F2(i,j) = min(1,F2(i,j)); %处理越界数据
        end
    end
end
figure;
imshow(F2),title('添加了20%高斯噪声的图像');
imwrite(F2,'添加了20%高斯噪声的图像.bmp','bmp');
%% Alpha-trimmed均值滤波
win_size = 5;  %滤波窗大小,规定为奇数
d = 15;
stride = 1; %步长
f1_1 = myfilter1(F1,win_size,stride,d);
f1_2 = myfilter1(F2,win_size,stride,d);
figure;
imshow(f1_1),title('alpha-trimmed均值滤波-椒盐噪声');
figure;
imshow(f1_2),title('alpha-trimmed均值滤波-高斯噪声');
imwrite(f1_1,'alpha-trimmed均值滤波-椒盐噪声.bmp','bmp');
imwrite(f1_2,'alpha-trimmed均值滤波-高斯噪声.bmp','bmp');
%% 自适应中值滤波
S_max = 7;  %自适应滤波器最大的窗口尺寸
S_min = 5;  %自适应滤波器最小的窗口尺寸,与padding的大小吻合
f2_1 = myfilter2(F1,S_max,S_min,stride);
f2_2 = myfilter2(F2,S_max,S_min,stride);
figure;
imshow(f2_1),title('自适应中值滤波-椒盐噪声');
figure;
imshow(f2_2),title('自适应中值滤波-高斯噪声');
imwrite(f2_1,'自适应中值滤波-椒盐噪声.bmp','bmp');
imwrite(f2_2,'自适应中值滤波-高斯噪声.bmp','bmp');



