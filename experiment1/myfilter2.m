function I = myfilter2(F,S_max,S_min,stride)
[m,n]=size(F); 
I = zeros([m,n]); 
pad_length = (S_max-1)/2;
F1_padding_2 = mypad(F,pad_length);  %自己编写的padding函数扩充边界
for i = pad_length+1:stride:pad_length+m
    for j = pad_length+1:stride:pad_length+n
        halfwins = (S_min-1)/2; %半窗长
        S1 = F1_padding_2(i-halfwins:i+halfwins,j-halfwins:j+halfwins);
        %第一步判断子窗要不要扩大
        while median(median(S1))==min(min(S1))||median(median(S1))==max(max(S1)) 
            halfwins= halfwins+1;
            if halfwins*2+1>S_max
                I(i-pad_length,j-pad_length) = median(median(S1));
                break;
            end
            S1 = F1_padding_2(i-halfwins:i+halfwins,j-halfwins:j+halfwins);
        end
        %第二步确定该点像素的值
        if halfwins<=S_max
            if S1(halfwins+1,halfwins+1)==min(min(S1))||S1(halfwins+1,halfwins+1)==max(max(S1))
                I(i-pad_length,j-pad_length) = median(median(S1));
            else
                I(i-pad_length,j-pad_length) = S1(halfwins+1,halfwins+1);
            end
        end
    end
end