function [ EPat, W ] = Spat_PatEstimation_nosubspace( NL_mat, Self_arr, Sigma_arr, CurPat, Par,iter,ss_size)
        EPat = zeros(size(CurPat));
        W    = zeros(size(CurPat));
        Spa_Size  = size(W, 1);
        NL_Size   = Par.patnum;
        Band_Size = size(W, 3);
        
%         sub_spectral = subspectral( CurPat,NL_mat);
        sub_spectral = zeros(1,size(NL_mat,2))+ss_size;
%         sub_space = subspace( CurPat,NL_mat);       
        
        for  i      =  1 : length(Self_arr)                                 % For each keypatch group
            Temp = CurPat(:, NL_mat(1:Par.patnum,i),:);
%% Spectral dimension reduction + Nonlocal low-rank            
%             [SpecDimReduction_Img, A]  =  v2_SPecDim_Reduction( Temp,sub_spectral(i));
            M_2     =   ndim_unfold(Temp, 2);
            E_2 	=   WNNM(M_2, Par.c1, Sigma_arr(Self_arr(i)));          % WNNM Estimation
            E_Temp2 =   ndim_fold(E_2, 2, size(Temp));
%             E_Img2  =   reshape(reshape(E_Temp2, Spa_Size * NL_Size, sub_spectral(i)) * A',Spa_Size, NL_Size, Band_Size);
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
            E_Temp  =  E_Temp2;
            EPat(:,NL_mat(1:Par.patnum,i),:)  = EPat(:,NL_mat(1:Par.patnum,i),:) + E_Temp;      
            W(:,NL_mat(1:Par.patnum,i),:)     = W(:,NL_mat(1:Par.patnum,i),:) + ones(size(CurPat,1),size(NL_mat(1:Par.patnum,i),1),size(CurPat,3));
        end
        if iter<5
            Par.c1 = Par.c1*1.5;
        else
            Par.c1 = Par.c1;
        end
end

