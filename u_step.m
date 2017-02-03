function [ y ] = u_step( x )
%u_step
% y = 0  , x < 0
% y = 1  , x > 0
% y = 1/2, x = 0
y=zeros(size(x));

for i = 1:max(size(x))
if x(i) < 0
    y(i) = 0;
elseif x(i) == 0
    y(i) = 1/2;
else %x(i) > 0
    y(i) = 1;    
end

end

