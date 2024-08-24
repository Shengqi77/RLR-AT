function   x   =  soft_Lp_shrink( y, lambda, p )

% Modified by Dr. Weisheng Dong 
J     =   2;
tau   =  (2*lambda.*(1-p))^(1/(2-p)) + p*lambda.*(2*(1-p)*lambda)^((p-1)/(2-p));
x     =   zeros( size(y) );
i0    =   find( abs(y)>tau );

if length(i0)>=1
    % lambda  =   lambda(i0);
    y0    =   y(i0);
    t     =   abs(y0);
    for  j  =  1 : J
        t    =  abs(y0) - p*lambda.*(t).^(p-1);
    end
    x(i0)   =  sign(y0).*t;
end