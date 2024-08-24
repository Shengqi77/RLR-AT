function  [par]=ParSet(nSig)

%% Patch-based Iteration Parameters
par.nSig        =   nSig;                               % Variance of the noise image
par.SearchWin   =   30;                                 % Non-local patch searching window
par.c1          =   10*sqrt(2);                         % Constant num for spatial
% par.c1          =   1.5*sqrt(2);                         % Constant num for color
par.c2          =   2*sqrt(2);
%% Image-based Iteration Parameters
par.Innerloop_X   =   20;                                  % InnerLoop Num of estimating clear image
% par.kappa    = 0.05;
par.kappa    = 0.5;
par.alpha1   = 10;    par.rho1     = 1;
par.alpha2   = 1;    par.rho2     = 1;
par.belta_1  = 0.01;    par.lambda_1 = 0.1;
par.belta_2  = 0.01;    par.lambda_2 = 0.1;
par.belta_3  = 1;    par.lambda_3 = 0.8;
% par.belta_3  = 0.2;    par.lambda_3 = 0.8;

%% Patch and noise Parameters
if nSig<=10
    par.patsize       =   6;
    par.patnum        =   400;
    par.Iter          =   1;
    par.lamada        =   0.54;     
elseif nSig <= 30
    par.patsize       =   7;
    par.patnum        =   300;
    par.Iter          =   3;
%     par.lamada        =   0.56; 
    par.lamada        =   0.60; 
else
    par.patsize       =   8;
    par.patnum        =   350;
    par.Iter          =   4;
    par.lamada        =   0.58; 
end
% par.step      =   floor((par.patsize)/2-1);       
par.step      =  5;
