function [ EPat, W ] = Spec_ImgEstimationS( Self_arr, Sigma_arr, CurPat, Par)
        EPat = zeros(size(CurPat));
        W    = zeros(size(CurPat));
        R    =  Par.patsize*Par.patsize;
        C    =  size(CurPat,1)/R;
        for  i      =  1 : length(Self_arr)                                 % For each keypatch group
            Temp_Vec    =   CurPat(:, Self_arr(i));                             % Non-local similar patches to the keypatch
            Temp_Mat    =   reshape(Temp_Vec,R,C);
            M_Temp      =   repmat(mean( Temp_Mat, 2 ),1,C);
            Temp        =   Temp_Mat - M_Temp;
            E_Mat 	    =   WNNM(Temp, Par.c2, Sigma_arr(Self_arr(i))) + M_Temp; % WNNM Estimation
            E_Vec       =   reshape(E_Mat,R*C,1);
            EPat(:,Self_arr(i))  = EPat(:,Self_arr(i)) + E_Vec;      
            W(:,Self_arr(i))     = W(:,Self_arr(i)) + ones(size(CurPat,1),1);
        end
        Par.c2 = Par.c2*1.5;
end

