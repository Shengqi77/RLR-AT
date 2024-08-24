function [SpecDimReduction_Img, A] = v2_SPecDim_Reduction( Input,Detect_subspace)

[Height, Width, Band] = size(Input);
Area            =  Height * Width;
Matrix_Input    =  reshape(Input, Area, Band)';
[A,S,~]         =  svd(Matrix_Input,'econ');


A               =  A(:,1:Detect_subspace);
SpecDimReduction_Img = reshape((A' * Matrix_Input)', Height, Width, Detect_subspace);

end

