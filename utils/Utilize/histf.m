function hist = histf( matin )
% 统计直方图
% matin -- 输入矩阵,该矩阵中的数据必须为整数
% hist -- 输出直方图, 其中hist为N*2大小，第一行记录灰度级数，第二行记录灰度级数出现的概率
mi = min( matin( : ) );
mx = max( matin( : ) );

h = zeros( mx - mi + 1, 2 );
h2 = h;

arr = matin( : );
arr = sort( arr, 'ascend' );
for i = 1 : numel( arr )
    index = arr( i );
    index2 = index - mi + 1;
    h( index2, 1 ) = index;
    h( index2, 2 ) = h( index2, 2 ) + 1;
end

% 除去矩阵中没有的灰度级数
index = 1;
for i = 1 : size( h, 1 )
    if h( i, 2 ) > 0
        h2( index, : ) = h( i, : );
        index = index + 1;
    end
end
index = index - 1;
h2( 1 : index, 2 ) = h2( 1 : index, 2 ) / size( matin, 1 ) / size( matin, 2 );
hist = h2( 1 : index, : );
