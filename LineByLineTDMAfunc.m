function [theta,x] = LineByLineTDMAfunc(a,b,c,d,n)
% for dx = dy
% the coefficient matrix d and e,h,D matrices depends on the problem definition 
D = d;
x = 0;
theta = zeros(n*(n+1),1); % initialization of unknown temperature values
% sweeping in the x-direction and traversing in the y-direction
for q = n:-1:1
    err = 1;
    
    while (err >= 1e-6)                                % iterates untill the error is less than the tolerance value
        for i = q:-1:1                                 % sweeping in the -ve x-direction
            j = n*(i-1);
            k = n*(i+1);
            d = D;
            e = transpose(theta((k-n+1):k));
            
            if i==1
                d = d+2*e;
            else
                h = transpose(theta((j-n+1):j));
                d = h+d+e;
            end
        
            theta((n*i-n+1):n*i) = TDMAfunc(a,b,c,d,n);
        end
        
        t = theta((n*q-n+1):n*q);                      % storing the values of theta of a column for error calculation
        
        for i=2:q                                      % sweeping through +ve x-direction i.e.; reversing to first
            j = n*(i-1);
            k = n*(i+1);
            d = D;
            e = transpose(theta((k-n+1):k));
            h = transpose(theta((j-n+1):j));

            d = h+d+e;
        
            theta((n*i-n+1):n*i) = TDMAfunc(a,b,c,d,n);
        end
        
        error = theta((n*q)-n+1:n*q) - t;              % difference between the values obtained by iterating in +ve x and -ve x-direction
        err = max(error);
        x = x+1;                                       % to get total number of iterations completed
    end
end
