function   x   =  solve_Lp( youtx, beta, alpha )

refx = ( 2*(1-alpha)/beta );
x0 = refx^( 1/(2-alpha) ) + alpha/beta*refx^( (alpha-1)/(2-alpha) );
youtx0 = max( x0, abs(youtx) ); % abs(youtx); %
youtx1 = youtx0 - alpha/beta*(youtx0).^(alpha-1);
x = sign(youtx) .* ( youtx0 > (x0) ) .* youtx1;