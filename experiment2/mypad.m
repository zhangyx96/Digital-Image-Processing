function B = mypad(A,pad_length)
[m,n] = size(A);
B = zeros([m+2*pad_length,n+2*pad_length]);
B(pad_length+1:pad_length+m,pad_length+1:pad_length+n)=A;
B(1:pad_length,:) = repmat(B(pad_length+1,:),pad_length,1);
B(end-pad_length+1:end,:) = repmat(B(end-pad_length,:),pad_length,1);
B(:,1:pad_length) = repmat(B(:,pad_length+1),1,pad_length);
B(:,end-pad_length+1:end) = repmat(B(:,end-pad_length),1,pad_length);