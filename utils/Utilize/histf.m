function hist = histf( matin )
% ͳ��ֱ��ͼ
% matin -- �������,�þ����е����ݱ���Ϊ����
% hist -- ���ֱ��ͼ, ����histΪN*2��С����һ�м�¼�Ҷȼ������ڶ��м�¼�Ҷȼ������ֵĸ���
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

% ��ȥ������û�еĻҶȼ���
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
