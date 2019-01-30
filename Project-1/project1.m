clear;clc;close all;
%% Picture 1
pic1 = imread('Up or Down.bmp');
figure;
imshow(pic1);
Ul = 400;
Ur = 450;
color = [255,255,255];
for i = 60:120
    pic1(i,Ul,:) = color;
    pic1(i,Ur,:) = color;
end
for j = Ul:Ur
    k = floor(10*log(-abs(j-425)/25+2))+120;
    pic1(k,j,:) = color;
end
imshow(pic1);
imwrite(pic1,'answer.bmp','bmp'),
%% Picture 2
pic2 = imread('tsukuba-left.bmp');
pic_d = double(pic2);
[m,n] = size(pic2);
pic_pad = [pic_d(1,:);pic_d(1,:);pic_d;pic_d(m,:);pic_d(m,:)];
pic_pad = [pic_pad(:,1) pic_pad(:,1) pic_pad  pic_pad(:,n) pic_pad(:,n)];
k = 3;
pic2_zoom = double(zeros(k*m,k*n));

% for i=1:k*m
%     dx=i/k-floor(i/k);
%     i1=floor(i/k)+2;
%     RX=[R(1+dx) R(dx) R(1-dx) R(2-dx)];
%     for j=1:k*n
%         dy=j/k-floor(j/k);
%         j1=floor(j/k)+2;
%         RY=[R(1+dy);R(dy);R(1-dy);R(2-dy)];
%         F=[pic_pad(i1-1,j1-1) pic_pad(i1-1,j1) pic_pad(i1-1,j1+1) pic_pad(i1-1,j1+2)
%             pic_pad(i1,j1-1) pic_pad(i1,j1) pic_pad(i1,j1+1) pic_pad(i1,j1+2)
%             pic_pad(i1+1,j1-1) pic_pad(i1+1,j1) pic_pad(i1+1,j1+1) pic_pad(i1+1,j1+2)
%             pic_pad(i1+2,j1-1) pic_pad(i1+2,j1) pic_pad(i1+2,j1+1) pic_pad(i1+2,j1+2)];
%         pic2_zoom(i,j)=(RX*F*RY);
%     end
% end
%imshow(uint8(pic2_zoom));

for i=1:k*m
    for j=1:k*n
        pic2_zoom(i,j)=Bicubic(i/k,j/k,pic_pad);
    end
end
figure;
imshow(uint8(pic2_zoom));

M = 1.5*n;
N = 1.5*n;
pic_r = zeros(M,N);
M1 = [1,0,0;0,-1,0;-0.5*N,0.5*M,1];
theta = 35;
M2 = [cosd(theta),-sind(theta),0;sind(theta),cosd(theta),0;0,0,1];
M3 = [cosd(theta),sind(theta),0;-sind(theta),cosd(theta),0;0,0,1];
M4 = [1,0,0;0,-1,0;0.5*m,0.5*n,1];
for i = 1:N
    for j = 1:M
        P1 = [i-1,j-1,1]; %P1 Matrix coordinate
        P2 = P1*M1; %P2 Math coordinate
        P3 = P2*M2; %P3 Math coordinate of origin picture
        P4 = P3*M4; %P4 Matrix coordinate of origin picture
        if P4(1)>=0 &&P4(1)<=m && P4(2)>=0&&P4(2)<=n
            pic_r(i,j)=Bicubic(P4(1),P4(2),pic_pad);
        end
    end
end
figure;
imshow(uint8(pic_r));

