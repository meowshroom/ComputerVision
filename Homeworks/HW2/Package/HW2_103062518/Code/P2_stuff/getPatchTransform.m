function [ img_post ] = getPatchTransform( img, mask_Target, hmgphyMat, bi_linear )
% img_post : ��s���ATransformed���Ϥ��A���B�n���a��OTransformed�����G
% ��l��������
% img : double�A[0~1]
% mask_Target�A���Ȫ������O�Ҧ��n�Q���o�̪�pixels
% homo_Target : X Y 1

%
[ h, w, ~ ] = size(img);
img_post = zeros(h, w, 3);

%% �Ҧ��ݭn�Q�񺡪�pixel���y��
[y, x] = find(mask_Target);
pixQt = length(y);

%% ���ȱq���̨�
src_homo = hmgphyMat * [ x' ; y' ; ones(1,pixQt) ];
x_src = src_homo(1,:) ./ src_homo(3,:);
y_src = src_homo(2,:) ./ src_homo(3,:);

%% ����Backward����
if bi_linear
%���u�ʤ���
	for pixI = 1 : pixQt
	
	%�p��4�ӾF�~���y���I
	upperY = floor( y_src(pixI) );
	lowerY  = ceil( y_src(pixI) );
	leftX     = floor( x_src(pixI) );
	rightX   = ceil( x_src(pixI) );
	%�p��4�Ӥ�V(�Wvs.�U�B��vs.�k)����v
	upperProportion = lowerY - y_src(pixI);
	lowerProportion = y_src(pixI) - upperY;
	leftProportion = rightX - x_src(pixI);
	rightProportion = x_src(pixI) - leftX;
	%���椺��
	img_post( y(pixI), x(pixI), : ) =...
		img( upperY, leftX, : ) * upperProportion * leftProportion +...
		img( lowerY, leftX, : ) * lowerProportion * leftProportion +...
		img( upperY, rightX, : ) * upperProportion * rightProportion +...
		img( lowerY, rightX, : ) * lowerProportion * rightProportion ;
	end
	
else
%�̪�F�~����
	for pixI = 1 : pixQt
		img_post( y(pixI), x(pixI), : ) = img( round(y_src(pixI)), round(x_src(pixI)), : );
	end
end

