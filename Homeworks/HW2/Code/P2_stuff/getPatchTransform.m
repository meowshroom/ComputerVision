function [ img_post ] = getPatchTransform( img, mask_Target, hmgphyMat, bi_linear )
% img_post : 後製的，Transformed的圖片，有遮罩的地方是Transformed的結果
% 其餘部分全黑
% img : double，[0~1]
% mask_Target，有值的部分是所有要被填到這裡的pixels
% homo_Target : X Y 1

%
[ h, w, ~ ] = size(img);
img_post = zeros(h, w, 3);

%% 所有需要被填滿的pixel的座標
[y, x] = find(mask_Target);
pixQt = length(y);

%% 的值從哪裡來
src_homo = hmgphyMat * [ x' ; y' ; ones(1,pixQt) ];
x_src = src_homo(1,:) ./ src_homo(3,:);
y_src = src_homo(2,:) ./ src_homo(3,:);

%% 執行Backward取值
if bi_linear
%雙線性內插
	for pixI = 1 : pixQt
	
	%計算4個鄰居的座標點
	upperY = floor( y_src(pixI) );
	lowerY  = ceil( y_src(pixI) );
	leftX     = floor( x_src(pixI) );
	rightX   = ceil( x_src(pixI) );
	%計算4個方向(上vs.下、左vs.右)的比率
	upperProportion = lowerY - y_src(pixI);
	lowerProportion = y_src(pixI) - upperY;
	leftProportion = rightX - x_src(pixI);
	rightProportion = x_src(pixI) - leftX;
	%執行內插
	img_post( y(pixI), x(pixI), : ) =...
		img( upperY, leftX, : ) * upperProportion * leftProportion +...
		img( lowerY, leftX, : ) * lowerProportion * leftProportion +...
		img( upperY, rightX, : ) * upperProportion * rightProportion +...
		img( lowerY, rightX, : ) * lowerProportion * rightProportion ;
	end
	
else
%最近鄰居內插
	for pixI = 1 : pixQt
		img_post( y(pixI), x(pixI), : ) = img( round(y_src(pixI)), round(x_src(pixI)), : );
	end
end

