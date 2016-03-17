function x = TDMAsolver(a,b,c,d,x0,xn)
%a, b, c are the column vectors for the compressed tridiagonal matrix, d is the right vector
n = length(d); % n is the number of rows
 
% Modify the first-row coefficients
% c(1) = c(1) / b(1);    % Division by zero risk.
% d(1) = d(1) / b(1);   
c(1)=0;
%d(1)=0;
d(1)=x0;
for i = 2:n-1
    temp = b(i) - a(i-1) * c(i-1);
    c(i) = c(i) / temp;
    d(i) = (d(i) - a(i-1) * d(i-1))/temp;
end
 
d(n) = (d(n) - a(n-1) * d(n-1))/( b(n) - a(n-1) * c(n-1));
 
% Now back substitute.
x(n) = xn;
for i = n-1:-1:1
    x(i) = d(i) - c(i) * x(i + 1);
end

end