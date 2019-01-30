function I = myfilter2(F,S_max,S_min,stride)
[m,n]=size(F); 
I = zeros([m,n]); 
pad_length = (S_max-1)/2;
F1_padding_2 = mypad(F,pad_length);  %�Լ���д��padding��������߽�
for i = pad_length+1:stride:pad_length+m
    for j = pad_length+1:stride:pad_length+n
        halfwins = (S_min-1)/2; %�봰��
        S1 = F1_padding_2(i-halfwins:i+halfwins,j-halfwins:j+halfwins);
        %��һ���ж��Ӵ�Ҫ��Ҫ����
        while median(median(S1))==min(min(S1))||median(median(S1))==max(max(S1)) 
            halfwins= halfwins+1;
            if halfwins*2+1>S_max
                I(i-pad_length,j-pad_length) = median(median(S1));
                break;
            end
            S1 = F1_padding_2(i-halfwins:i+halfwins,j-halfwins:j+halfwins);
        end
        %�ڶ���ȷ���õ����ص�ֵ
        if halfwins<=S_max
            if S1(halfwins+1,halfwins+1)==min(min(S1))||S1(halfwins+1,halfwins+1)==max(max(S1))
                I(i-pad_length,j-pad_length) = median(median(S1));
            else
                I(i-pad_length,j-pad_length) = S1(halfwins+1,halfwins+1);
            end
        end
    end
end