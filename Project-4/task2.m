% ����ͼ������ҵ4(1) ��ͼ����ͼ���˶�ģ��
% ��Ԫ�� 2018210902
close all;clc;clear
pic_B =imread('imageBlur.bmp'); %load the image
pic_1 =imread('task1.bmp'); %load the image
g = double(rgb2gray(pic_B));%convert to double
f1 = double(rgb2gray(pic_1));
[m,n,d]=size(g);
G = fft2(myfftshift(g));
figure;
imshow(uint8(g));
title('ԭʼͼ��');
%�˻�����
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
%����ͼ�������ͷ���
Band = g(125:130,210:250);
[bm,bn] = size(Band); 
figure;
imshow(uint8(Band));
title('С����');
ps = zeros(1,256);  %����ֱ��ͼ
for i =1:bm
    for j = 1:bn
        ps(Band(i,j)+1)=ps(Band(i,j)+1)+1;  %ͳ��ÿ���Ҷ�ֵ���ֵ�Ƶ��
    end
end
ps = ps/(bm*bn);  
mu = 0;
figure;
plot(0:255,ps);
title('����ֱ��ͼ');
for i =0:255
    mu = mu+i*ps(i+1); %�����ֵ
end
var = 0;
for i =0:255
    var = var+(i-mu)^2*ps(i+1); %������������
end
MU = mean(mean(Band-mean(Band(:)))); %����������ֵ

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
t = ['�ָ���ͼ�� gamma =',num2str(gamma)];
title(t);
imwrite(uint8(f_result),'task2.bmp','bmp');

