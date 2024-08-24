function  [E_Img,W_Img]  =  Patch2Im( TImPat, TWPat, PatSize, ImageH, ImageW,ImageB )
    TempR        =   ImageH-PatSize+1;
    TempC        =   ImageW-PatSize+1;
    TempOffsetR  =   1:TempR;
    TempOffsetC  =   1:TempC;    
    E_Img  	=  zeros(ImageH,ImageW,ImageB);
    W_Img 	=  zeros(ImageH,ImageW,ImageB);
    k       =   0;
   bb=PatSize*PatSize;
   TotalPatNum = (size(E_Img,1)-PatSize+1)*(size(E_Img,2)-PatSize+1);  
   MImPat        =   zeros(bb*size(E_Img,3), TotalPatNum,'single'); 
   MWPat         =   zeros(bb*size(E_Img,3), TotalPatNum,'single'); 
for m = 1:TotalPatNum
    MImPat(:,m) = reshape(TImPat(:,m,:),bb*ImageB,1);
    MWPat(:,m)  = reshape(TWPat(:,m,:),bb*ImageB,1);
end    
    
for o = 1:ImageB
    for i  = 1:PatSize
        for j  = 1:PatSize
            k    =  k+1;
            E_Img(TempOffsetR-1+i,TempOffsetC-1+j,o)  =  E_Img(TempOffsetR-1+i,TempOffsetC-1+j,o) + reshape( MImPat(k,:)', [TempR TempC]);
            W_Img(TempOffsetR-1+i,TempOffsetC-1+j,o)  =  W_Img(TempOffsetR-1+i,TempOffsetC-1+j,o) + reshape( MWPat(k,:)',  [TempR TempC]);
        end
    end
end
%     E_Img  =  E_Img./(W_Img+eps);

    