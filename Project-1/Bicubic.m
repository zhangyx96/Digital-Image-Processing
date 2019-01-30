function pic = Bicubic(x,y,pic_pad)
dx=x-floor(x);
i1=floor(x)+2;
RX=[R(1+dx) R(dx) R(1-dx) R(2-dx)];
dy=y-floor(y);
j1=floor(y)+2;
RY=[R(1+dy);R(dy);R(1-dy);R(2-dy)];
F= [pic_pad(i1-1,j1-1) pic_pad(i1-1,j1) pic_pad(i1-1,j1+1) pic_pad(i1-1,j1+2)
    pic_pad(i1,j1-1) pic_pad(i1,j1) pic_pad(i1,j1+1) pic_pad(i1,j1+2)
    pic_pad(i1+1,j1-1) pic_pad(i1+1,j1) pic_pad(i1+1,j1+1) pic_pad(i1+1,j1+2)
    pic_pad(i1+2,j1-1) pic_pad(i1+2,j1) pic_pad(i1+2,j1+1) pic_pad(i1+2,j1+2)];
pic=(RX*F*RY);
