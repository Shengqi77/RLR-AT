function Refined =  Tensor_refinement( Registered, refine_parameters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Refined =  Tensor_refinement( Registered, refine_parameters)
% This function is the main routine for the Low-rank Tensor Refinement part
% (section 4.2 in the paper)
% Input: Registered - Each registered frame
%        reg_parameters  -  parameters for refinement  -  The sensitivity of weight function to frequency
% Output: Refined - Each refined frame
% Shengqi Xu, Run Sun, Yi Chang
% Copyright ECCV 2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Refined            = Registered;                                                        % Estimated Image
[Height, Width, Band]  = size(Refined);   
TotalPatNum      = (Height-refine_parameters.patsize+1)*(Width-refine_parameters.patsize+1);                 % Total Patch Number in the image
Average          = mean(Registered,3);                                                % Calculate the average band for fast spatial non-local searching
[Neighbor_arr, Num_arr, Self_arr] =	NeighborIndex(Average, refine_parameters);                 % PreCompute the all the patch index in the searching window 

for iter = 1 : refine_parameters.Iter        
    Average             =   mean(Refined,3);         
    [CurPat, Mat, Sigma_arr]	=	Im2Patch( Refined, Registered, Average, refine_parameters , iter);       % image to patch and estimate local noise variance 

     NL_mat  =  Block_matching(Mat, refine_parameters, Neighbor_arr, Num_arr, Self_arr);
     if(iter==1)
        Sigma_arr = refine_parameters.nSig * ones(size(Sigma_arr));       
     end
     ss_size = 1; 
     [EPat, W]    =  Spat_PatEstimation( NL_mat, Self_arr, Sigma_arr, CurPat, refine_parameters,iter,ss_size);   % Estimate the spatial patches
     [Spa_Img, Spa_Wei]   =  Patch2Im( EPat, W, refine_parameters.patsize, Height, Width, Band );
     [Refined]         =  ImUpdata(Registered, Spa_Img, Spa_Wei, sum(Sigma_arr)/TotalPatNum, refine_parameters );                % Estimate the clear images. 
     index = find(Spa_Wei<=3);
     Refined(index) = Registered(index);
end
return;


