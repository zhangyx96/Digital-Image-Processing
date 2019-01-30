% experiment3 Moment Invariants不变矩
clc;clear;close all;
Fig1 = imread('images/M1.bmp');  %读取原图像
Fig2 = imread('images/M2.bmp');
Fig3 = imread('images/M3.bmp');
Fig4 = imread('images/M4.bmp');
Fig5 = imread('images/M5.bmp');
Fig6 = imread('images/M6.bmp');
F = Fig6; %选定图像
f = double(rgb2gray(F)); %转灰度
eta20 = eta(f,2,0);
eta02 = eta(f,0,2);
eta11 = eta(f,1,1);
eta30 = eta(f,3,0);
eta03 = eta(f,0,3);
eta12 = eta(f,1,2);
eta21 = eta(f,2,1);
Phi1 = eta20+eta02;
Phi2 = (eta20-eta02)^2+4*eta11^2;
Phi3 = (eta30-3*eta12)^2+(3*eta21-eta03)^2;
Phi4 = (eta30+eta12)^2+(eta21+eta03)^2;
Phi5 = (eta30-3*eta12)*(eta30+eta12)*((eta30+eta12)^2-3*(eta21+eta03)^2)...
    +(3*eta21-eta03)*(eta21+eta03)*(3*(eta30+eta12)^2-(eta21+eta03)^2);
Phi6 = (eta20-eta02)*((eta30+eta12)^2-(eta21+eta03)^2)+4*eta11*(eta30+eta12)*(eta21+eta03);
Phi7 = (3*eta21-eta03)*(eta30+eta12)*((eta30+eta12)^2-3*(eta21+eta03)^2)...
    +(3*eta12-eta30)*(eta21+eta03)*(3*(eta30+eta12)^2-(eta21+eta03)^2);

Phi1 = abs(log10(Phi1))*sign(Phi1);
Phi2 = abs(log10(Phi2))*sign(Phi2);
Phi3 = abs(log10(Phi3))*sign(Phi3);
Phi4 = abs(log10(Phi4))*sign(Phi4);
Phi5 = abs(log10(Phi5))*sign(Phi5);
Phi6 = abs(log10(Phi6))*sign(Phi6);
Phi7 = abs(log10(Phi7))*sign(Phi7);

function r = m(f,p,q)
[M,N]=size(f);
X = 0:M-1;
X = repmat(X',1,N);
Y = 0:N-1;
Y = repmat(Y,M,1);
r = sum(sum(X.^p.*Y.^q.*f));
end

function r = mu(f,p,q)
[M,N]=size(f);
x_bar = m(f,1,0)/m(f,0,0);
y_bar = m(f,0,1)/m(f,0,0);
X = 0:M-1;
X = repmat(X',1,N);
Y = 0:N-1;
Y = repmat(Y,M,1);
r = sum(sum((X-x_bar).^p.*(Y-y_bar).^q.*f));
end

function r = eta(f,p,q)
gamma = (p+q)/2+1;
r = mu(f,p,q)/(mu(f,0,0)^gamma);
end

