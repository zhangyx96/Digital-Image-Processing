% 数字图像处理作业4(1) 对图像做图像运动模糊
% 张元鑫 2018210902
close all;clc;clear
pic_O =imread('imageOrg.bmp'); %load the image
pic_B =imread('imageBlur.bmp'); %load the image
figure;
imshow(pic_O);
title('原始图像');
f = im2double(pic_O);%convert to double
[m,n,d]=size(f);
f = myfftshift(f);  %用自己的fftshift偏差较大
F = fft2(f);

%退化函数
a = 0.1;
b = 0.1;
T = 1;
H = zeros([m,n]);
for u =1:m
    for v = 1:n
        u_t = u-0.5*m-1;
        v_t = v-0.5*n-1;
        temp =(u_t*a+v_t*b)*pi;
        if temp == 0
            H(u,v) = 1;
        else
            H(u,v)=T/temp*sin(temp)*exp(-1i*temp);
        end
    end
end
figure;
imshow(real(H));
title('H');
F_B=H.*F;
f_B = myIDFT2((F_B));
f_B = real(myfftshift(f_B));
figure;
imshow(f_B);
imwrite(f_B,'task1.bmp','bmp');




