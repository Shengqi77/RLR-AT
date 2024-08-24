% function [X]         =  ImUpdata(N_Img, Spa_Img, Spa_Wei, Spe_Img,Spe_Wei,nSig, opts )
function [X]         =  ImUpdata(N_Img, Spa_Img, Spa_Wei, nSig, opts )
% function [X]         =  ImUpdata(N_Img, opts )
%% initialization
[m,n,frame] = size(N_Img);
%%% construct the template
template_time = zeros(2,2,2);
m1 = [1 0;0 0 ];
m2 = [-1 0 ;0 0 ];
template_time(:,:,1) = m1;
template_time(:,:,2) = m2;
otfDx = psf2otf([1 -1],[m,n,frame]);
otfDy = psf2otf([1;-1],[m,n,frame]);
otfDz = psf2otf(template_time,[m,n, frame]);

Dx    = zeros(m,n,frame);
Dy    = zeros(m,n,frame);
Dz    = zeros(m,n,frame);
M     = zeros(m,n,frame);
N     = zeros(m,n,frame);

Bx    = zeros(m,n,frame);
By    = zeros(m,n,frame);
Bz    = zeros(m,n,frame);
J1    = zeros(m,n,frame);
J2    = zeros(m,n,frame);

%% out-loop iteration
for iter = 1:opts.Innerloop_X
    
    %% X - subproblem
%     Denom  =   opts.belta_1 * abs(otfDx).^2 + opts.belta_2 * abs(otfDy).^2 + opts.belta_3 * abs(otfDz).^2 + opts.alpha1 + opts.alpha2 + opts.kappa;  
%     Fx     =   ( opts.kappa * fftn( N_Img ) + conj(otfDx).*fftn(opts.belta_1 * Dx - Bx) + conj(otfDy).*fftn(opts.belta_2 * Dy - By) + conj(otfDz).*fftn(opts.belta_3 * Dz - Bz)+ fftn(opts.alpha1 * M - J1) + fftn(opts.alpha2 * N - J2))./Denom;     %% destriping 
%     X      =   real( ifftn( Fx ) );  
    
%     Denom  =   opts.belta_1 * abs(otfDx).^2 + opts.belta_2 * abs(otfDy).^2 + opts.belta_3 * abs(otfDz).^2 + opts.alpha1 + opts.kappa;  
%     Fx     =   ( opts.kappa * fftn( N_Img ) + conj(otfDx).*fftn(opts.belta_1 * Dx - Bx) + conj(otfDy).*fftn(opts.belta_2 * Dy - By) + conj(otfDz).*fftn(opts.belta_3 * Dz - Bz)+ fftn(opts.alpha1 * M - J1))./Denom;     %% destriping 
%     X      =   real( ifftn( Fx ) ); 

    Denom  =   opts.belta_3 * abs(otfDz).^2 + opts.alpha1 + opts.kappa;  
    Fx     =   ( opts.kappa * fftn( N_Img ) + conj(otfDz).*fftn(opts.belta_3 * Dz - Bz)+ fftn(opts.alpha1 * M - J1))./Denom;     %% destriping 
    X      =   real( ifftn( Fx ) );  

    %% M - subproblem
    M      =   (opts.rho1*Spa_Img + opts.alpha1 * X +  J1)./(opts.alpha1 + opts.rho1*Spa_Wei);              %% Spatial reconstruction
    J1     =    J1 + opts.alpha1*(X - M);
    opts.alpha1 = opts.alpha1*1.02;
    
    %% N - subproblem
%     N      =   (opts.rho2*Spe_Img + opts.alpha2 * X + J2)./(opts.alpha2 + opts.rho2*Spe_Wei);               %% Spectral reconstruction
%     J2     =    J2 + opts.alpha2*(X - N);
%     opts.alpha2 = opts.alpha2*1.02;
    
    %% Dx, Dy and Dz- subproblem
%     Du_x   =   real(ifftn(otfDx.*fftn(X)));                                % column diff
%     Dx     =   soft_L1_shrink(Bx/opts.belta_1 + Du_x, opts.lambda_1/opts.belta_1);
%     
%     Du_y   =   real(ifftn(otfDy.*fftn(X)));                                 % row diff 
%     Dy     =   soft_L1_shrink(By/opts.belta_2 + Du_y, opts.lambda_2/opts.belta_2);
    
    Du_z   =   real(ifftn(otfDz.*fftn(X)));                                % spectral diff
    Dz     =   soft_L1_shrink(Bz/opts.belta_3 + Du_z, nSig^2*opts.lambda_3/opts.belta_3); % Here, we find the L1 norm is even better than Lp norm.
%     Dz     =   soft_Lp_shrink(Bz/opts.belta_3 + Du_z, opts.lambda_3/opts.belta_3, 0.7);
    
    %% updata Bx, By, Bz
    
%     Bx     =    Bx + opts.belta_1*(Du_x - Dx);
%     By     =    By + opts.belta_2*(Du_y - Dy);
    Bz     =    Bz + opts.belta_3*(Du_z - Dz);
%     opts.belta_1 = opts.belta_1*1.02;
%     opts.belta_2 = opts.belta_2*1.02;
    opts.belta_3 = opts.belta_3*1.02;
%     opts.lambda_3 = opts.lambda_3/1.2;
end
end