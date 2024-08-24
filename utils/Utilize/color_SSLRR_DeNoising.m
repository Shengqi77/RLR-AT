function [E_Img]   =  color_SSLRR_DeNoising( N_Img, O_Img, Par,Cb,Cr,save_dir )

E_Img            = N_Img;                                                        % Estimated Image
[Height, Width, Band]  = size(E_Img);   
TotalPatNum      = (Height-Par.patsize+1)*(Width-Par.patsize+1);                 % Total Patch Number in the image
Average          = mean(N_Img,3);                                                % Calculate the average band for fast spatial non-local searching
[Neighbor_arr, Num_arr, Self_arr] =	NeighborIndex(Average, Par);                 % PreCompute the all the patch index in the searching window 

for iter = 1 : Par.Iter        
    Average             =   mean(E_Img,3);         
    [CurPat, Mat, Sigma_arr]	=	Im2Patch( E_Img, N_Img, Average, Par ,O_Img, iter);       % image to patch and estimate local noise variance 

     NL_mat  =  Block_matching(Mat, Par, Neighbor_arr, Num_arr, Self_arr);
     if(iter==1)
        Sigma_arr = Par.nSig * ones(size(Sigma_arr));       
     end
     ss_size = 1; %每次迭代过程中子空间大小
     [EPat, W]    =  Spat_PatEstimation( NL_mat, Self_arr, Sigma_arr, CurPat, Par,iter,ss_size);   % Estimate the spatial patches
     [Spa_Img, Spa_Wei]   =  Patch2Im( EPat, W, Par.patsize, Height, Width, Band );
%      summ = sum(sum(ismissing(Spa_Wei)));
%      if summ>0
%         test = 1;
%      end
     [E_Img]         =  ImUpdata(N_Img, Spa_Img, Spa_Wei, sum(Sigma_arr)/TotalPatNum, Par );                % Estimate the clear images. Comment out this line means no spectral hyper-laplacian.
     %如果有块没有用到，则直接用退化图像对应部分给抵上
     index = find(Spa_Wei<=3);
     E_Img(index) = N_Img(index);
     for i = 1:size(E_Img,3)
        E_Img_color = YCBCR2RGB(E_Img(:,:,i),Cb,Cr);
    
        imwrite(uint8(E_Img_color),[save_dir,num2str(i),'_.png'])
     end
     
%      PSNR  = csnr( O_Img, E_Img, 0, 0 );
%      SSIM  = cal_ssim( O_Img, E_Img, 0, 0 );
%     fprintf( 'Iter = %2.3f, PSNR = %2.2f, SSIM = %2.3f, NoiseLevel = %2.3f \n', iter, PSNR, SSIM, sum(Sigma_arr)/TotalPatNum);
end
return;


