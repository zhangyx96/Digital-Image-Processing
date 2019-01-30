% 数字图像处理作业4(1) 对图像做图像运动模糊
% 张元鑫 2018210902
close all;clc;clear
pic_B =imread('imageBlur.bmp'); %load the image
pic_1 =imread('task1.bmp'); %load the image
g = double(rgb2gray(pic_B));%convert to double
f1 = double(rgb2gray(pic_1));
[m,n,d]=size(g);
G = fft2(myfftshift(g));
figure;
imshow(uint8(g));
title('原始图像');
%退化函数
a = 0.1;
b = 0.1;
T = 1;
H = zeros([m,n]);
for u =1:m
    for v = 1:n
        u_t = u-0.5*m-1;
        v_t = v-0.5*n-1;
        temp = pi*(u_t*a+v_t*b);
        if temp == 0
            H(u,v) = 1;
        else
            H(u,v)=T/temp*sin(temp)*exp(-1i*temp);
        end
    end
end
%估计图像噪声和方差
Band = g(125:130,210:250);
[bm,bn] = size(Band); 
figure;
imshow(uint8(Band));
title('小条带');
ps = zeros(1,256);  %概率直方图
for i =1:bm
    for j = 1:bn
        ps(Band(i,j)+1)=ps(Band(i,j)+1)+1;  %统计每个灰度值出现的频率
    end
end
ps = ps/(bm*bn);  
mu = 0;
figure;
plot(0:255,ps);
title('概率直方图');
for i =0:255
    mu = mu+i*ps(i+1); %计算均值
end
var = 0;
for i =0:255
    var = var+(i-mu)^2*ps(i+1); %计算噪声方差
end
MU = mean(mean(Band-mean(Band(:)))); %计算噪声均值

p =zeros([m,n]);
p(1:3,1:3) = [0,-1,0;-1,4,-1;0,-1,0]; 
p = myfftshift(p);
P = myDFT2(p);

eta_square = sum(m*n*(MU.^2+var));
Fc = zeros([m,n,d]);
gamma =0.01;
eps = 1e6;
r_square = 0;
H_c = conj(H);
while(r_square<eta_square-eps || r_square>eta_square+eps)
    Fc = (H_c./(H_c.*H + gamma*abs(P).^2)).*G;
    R = G-H.*Fc;
    r = real(myIDFT2(R));
    r = myfftshift(r);
    r_square = sum(sum(r.^2));
    if gamma == 0
        break;
    elseif r_square<eta_square-eps
        gamma = gamma*1.05;
    else
        gamma = gamma*0.95;
    end
    display(gamma);
    display(eta_square-eps);
    display(r_square);
end
f_result = ifft2(Fc);
f_result = real(myfftshift(f_result));
figure;
imshow(uint8(f_result));
t = ['恢复后图像 gamma =',num2str(gamma)];
title(t);
imwrite(uint8(f_result),'task2.bmp','bmp');

