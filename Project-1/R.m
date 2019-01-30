function y =R(input)  
x=abs(input);  
if x>=0 && x<=1  
   y=2/3+0.5*x^3-x^2; 
elseif x>=1 && x<=2  
   y=(2-x)^3/6;  
else  
   y=0;  
end 
