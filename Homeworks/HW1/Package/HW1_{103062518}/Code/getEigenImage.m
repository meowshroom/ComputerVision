function [ smallEigenValue, bigEigenValue ] = getEigenImage( img, filterSize )
%輸出一個Image
%
%

h = size(img,1);		w = size(img,2);

%先做sobelFiltering
sobelFilter_UD = fspecial('sobel');
sobelFilter_DU = flipud(sobelFilter_UD);
sobelFilter_LR = sobelFilter_UD';
sobelFilter_RL = fliplr(sobelFilter_LR);

filteredImage_LR = double( imfilter(img, sobelFilter_LR, 'same') )/255;
filteredImage_RL = double( imfilter(img, sobelFilter_RL, 'same') )/255;
filteredImage_UD = double( imfilter(img, sobelFilter_UD, 'same') )/255;
filteredImage_DU = double( imfilter(img, sobelFilter_DU, 'same') )/255;

%原影像的梯度值(二維)就是：以向下為正，以向右為正
img_Vertical_Gradient = filteredImage_UD - filteredImage_DU;
img_Horizontal_Gradient = filteredImage_LR - filteredImage_RL;

%
padding = (filterSize-1) / 2;

smallEigenValue = zeros( h, w );
bigEigenValue = zeros( h, w );

%%取patch和eigenValue
for yI = 1+padding : h-padding
	for xI = 1+padding : w-padding
		
		patchGradientY = img_Vertical_Gradient( yI-padding:yI+padding, xI-padding:xI+padding);
		patchGradientX = img_Horizontal_Gradient( yI-padding:yI+padding, xI-padding:xI+padding);
		
		Ix2 = patchGradientX .^ 2;
		Iy2 = patchGradientY .^ 2;
		IxIy = patchGradientX .* patchGradientY;
		structureTensor = [ sum(sum(Ix2)), sum(sum(IxIy)); sum(sum(IxIy)), sum(sum(Iy2)) ];
		
		smallEigenValue( yI, xI ) = min( eig( structureTensor ) );
		bigEigenValue( yI, xI ) = max( eig( structureTensor ) );
		
	end
end



end %function end

