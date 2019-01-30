function I = myfilter1(F,win_size,stride,d)
[m,n]=size(F);
I = zeros([m,n]);
pad_length = (win_size-1)/2;
F_padding = mypad(F,pad_length);  %����߽�
for i = pad_length+1:stride:pad_length+m
    for j = pad_length+1:stride:pad_length+n
        g = F_padding(i-pad_length:i+pad_length,j-pad_length:j+pad_length);%g����
        g = reshape(g,win_size^2,1); %����ת����
        g = sort(g);   %����
        if mod(d,2)==0  %����d����ż����ֱ����
            gr = sum(g(d/2+1:end-d/2))/(win_size^2-d);
        else
            gr = sum(g((d+1)/2+1:end-(d-1)/2))/(win_size^2-d);
        end
        I(i-pad_length,j-pad_length) = gr; 
    end
end