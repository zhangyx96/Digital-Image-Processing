clc;clear;close all;
Fig = imread('board-orig.bmp');  %��ȡԭͼ��
[m,n]=size(Fig);  %ԭͼ��ߴ�
figure(1);
imshow(Fig),title('ԭʼͼ��');
F = im2double(Fig); %ת��double����
%% ��ӽ�������
F1 = F;
n1 = rand([m,n]);  %����[0,1]�����������
for i=1:m
    for j =1:n
        if(n1(i,j)<0.25)  %����25%�Ľ�������
            F1(i,j)=randi([0,1]); %���������������������
        end
    end
end
figure;
imshow(F1),title('�����25%����������ͼ��');
imwrite(F1,'�����25%����������ͼ��.bmp','bmp');
%% ��Ӹ�˹����
F2 = F;
mean = 20;  %��ֵ
sigma = sqrt(400); %��׼��
n2 = rand([m,n]);  %����[0,1]�����������
for i=1:m
    for j =1:n
        if(n2(i,j)<0.2)
            F2(i,j)=normrnd(mean,sigma)/255+F2(i,j);  %��Ӹ�˹����
            F2(i,j) = max(0,F2(i,j));
            F2(i,j) = min(1,F2(i,j)); %����Խ������
        end
    end
end
figure;
imshow(F2),title('�����20%��˹������ͼ��');
imwrite(F2,'�����20%��˹������ͼ��.bmp','bmp');
%% Alpha-trimmed��ֵ�˲�
win_size = 5;  %�˲�����С,�涨Ϊ����
d = 15;
stride = 1; %����
f1_1 = myfilter1(F1,win_size,stride,d);
f1_2 = myfilter1(F2,win_size,stride,d);
figure;
imshow(f1_1),title('alpha-trimmed��ֵ�˲�-��������');
figure;
imshow(f1_2),title('alpha-trimmed��ֵ�˲�-��˹����');
imwrite(f1_1,'alpha-trimmed��ֵ�˲�-��������.bmp','bmp');
imwrite(f1_2,'alpha-trimmed��ֵ�˲�-��˹����.bmp','bmp');
%% ����Ӧ��ֵ�˲�
S_max = 7;  %����Ӧ�˲������Ĵ��ڳߴ�
S_min = 5;  %����Ӧ�˲�����С�Ĵ��ڳߴ�,��padding�Ĵ�С�Ǻ�
f2_1 = myfilter2(F1,S_max,S_min,stride);
f2_2 = myfilter2(F2,S_max,S_min,stride);
figure;
imshow(f2_1),title('����Ӧ��ֵ�˲�-��������');
figure;
imshow(f2_2),title('����Ӧ��ֵ�˲�-��˹����');
imwrite(f2_1,'����Ӧ��ֵ�˲�-��������.bmp','bmp');
imwrite(f2_2,'����Ӧ��ֵ�˲�-��˹����.bmp','bmp');



