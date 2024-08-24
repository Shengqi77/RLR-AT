function  [Y1, Mat, SigmaArr]  =  Im2Patch( E_Img,N_Img, Average, par , iter)
TotalPatNum = (size(E_Img,1)-par.patsize+1)*(size(E_Img,2)-par.patsize+1);                  %Total Patch Number in the image
Y           =   zeros(par.patsize*par.patsize*size(E_Img,3), TotalPatNum, 'single');        %Current Patches
N_Y         =   zeros(par.patsize*par.patsize*size(E_Img,3), TotalPatNum, 'single');        %Patches in the original noisy image
Mat         =   zeros(par.patsize*par.patsize, TotalPatNum, 'single');                      %Patches in the original noisy image
bb          =   par.patsize*par.patsize;
cc          =   size(E_Img,3);
k           =   0;


for o = 1:size(E_Img,3)
    for i  = 1:par.patsize
        for j  = 1:par.patsize
            k     =  k+1;
            E_patch     =  E_Img(i:end-par.patsize+i,j:end-par.patsize+j,o);
            N_patch     =  N_Img(i:end-par.patsize+i,j:end-par.patsize+j,o);
            
            Y(k,:)      =  E_patch(:)';
            N_Y(k,:)    =  N_patch(:)';
        end
    end
end
Y1         =   zeros(par.patsize*par.patsize, TotalPatNum, size(E_Img,3), 'single'); 
for m = 1:TotalPatNum
    Y1(:,m,:) = reshape(Y(:,m),bb,1,cc);
end



k           =   0;
for i  = 1:par.patsize
    for j  = 1:par.patsize
        k     =  k+1;
        Mat_patch   =  Average(i:end-par.patsize+i,j:end-par.patsize+j);
        Mat(k,:)    =  Mat_patch(:)';
    end
end


% [Noise_level, ~] = NoiseLevel(E_Img);
% if par.nSig<20
%     SigmaArr  =  repmat(1.5+Noise_level,1,TotalPatNum);
% else
%     SigmaArr  =  repmat(2.5+Noise_level,1,TotalPatNum);
% end

% SigmaArr = par.lamada*sqrt(abs(repmat(par.nSig^2,1,size(Y,2))-mean((N_Y-Y).^2)));
% for cave
if iter < 6
    SigmaArr = 0.7*sqrt(abs(repmat(par.nSig^2,1,size(Y,2))-mean((N_Y-Y).^2)));%Estimated Local Noise Level
else
    SigmaArr = 0.4*sqrt(abs(repmat(par.nSig^2,1,size(Y,2))-mean((N_Y-Y).^2)));
end