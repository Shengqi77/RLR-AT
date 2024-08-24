function [ E_SpecCubic, W ] = Spec_ImgEstimationL( E_Img,N_Img,Par,iter)

[Height, Width, Band]  = size(E_Img);
SigmaArr = Par.lamada*sqrt(abs(Par.nSig^2- mean(mean(reshape(N_Img,[Height * Width, Band])-reshape(E_Img,[Height * Width, Band]))).^2));
        if(iter==1)
            SigmaArr = Par.nSig;                         % First Iteration use the input noise parameter
        end
N_SpecOri              = reshape(E_Img,[Height * Width, Band]);
N_SpecMean             = repmat(mean( N_SpecOri, 2 ),1,Band);
N_SpecInner            = N_SpecOri - N_SpecMean;
E_SpecMat 	           = WNNM(N_SpecInner, Par.c2, SigmaArr) + N_SpecMean; % WNNM Estimation
E_SpecCubic            = reshape(E_SpecMat, [Height, Width, Band]);
W                      = ones(size(E_SpecCubic));

end

