function [ EPat, W ] = Spat_PatEstimation( NL_mat, Self_arr, Sigma_arr, CurPat, Par,iter,ss_size)
        EPat = zeros(size(CurPat));
        W    = zeros(size(CurPat));
        Spa_Size  = size(W, 1);
        NL_Size   = Par.patnum;
        GL_Size   = size(Sigma_arr,2);
        Band_Size = size(W, 3);
        
%         sub_spectral = subspectral( CurPat,NL_mat);
        sub_spectral = zeros(1,size(Sigma_arr,2))+ss_size;
%         sub_space = subspace( CurPat,NL_mat);       
                              % For each keypatch group
%             Temp = CurPat(:, NL_mat(1:Par.patnum,i),:);


           Temp = CurPat(:, :,:);
%% Spectral dimension reduction + Nonlocal low-rank            
            [SpecDimReduction_Img, A]  =  v2_SPecDim_Reduction( Temp,1);
            M_2     =   ndim_unfold(SpecDimReduction_Img, 2);
            E_2 	=   WNNM(M_2, Par.c1, 5);          % WNNM Estimation
            E_Temp2 =   ndim_fold(E_2, 2, size(SpecDimReduction_Img));
            E_Img2  =   reshape(reshape(E_Temp2, Spa_Size * GL_Size, 1) * A',Spa_Size, GL_Size, Band_Size);
%% NL dimension reduction + Spectral low-rank
%             [ NLDimReduction_Img, B]  =  v2_NLDim_Reduction(Temp,sub_space(i));
%             NL_subspace = sub_space(i);
%             Par.NL_subspace = NL_subspace;
%             M_3     =   ndim_unfold(NLDimReduction_Img, 3);
%             E_3 	=   WNNM(M_3, Par.c3, Sigma_arr(Self_arr(i))); % WNNM Estimation
%             E_Temp3 =   ndim_fold(E_3, 3, size(NLDimReduction_Img));
%             E_Img3  =   permute(reshape(reshape(permute(E_Temp3,[1 3 2]), Spa_Size * Band_Size, NL_subspace) * B',Spa_Size, Band_Size, NL_Size),[1 3 2]); 
%% Reconstruction
%             E_Temp  =  0.6*E_Img3 + 0.4*E_Img2;
            E_Temp  =  E_Img2;
            EPat(:,:,:)  = EPat(:,:,:) + E_Temp;      
            W(:,:,:)     = W(:,:,:) + ones(size(CurPat,1),size(CurPat,2),size(CurPat,3));
        if iter<5
            Par.c1 = Par.c1*1.5;
        else
            Par.c1 = Par.c1;
        end
end
