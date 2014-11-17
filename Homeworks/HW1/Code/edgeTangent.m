function [edgeTan1 , edgeTan2] =  edgeTangent ( img )
%找出Gradient的切線方向

h = size(img,1);		w = size(img,2);
edgeTan1 = zeros( h, w );
edgeTan2 = zeros( h, w );

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

% 0:沒有Gradient 1:上下 2:左右 3:右上左下 4:左上右下
dirs = [	0,1;	1,0;	1,1;	-1,1];
tans = [     1,		 2,		  3,		4	];

for yI = 2 : h-1
	for xI = 2 : w-1
		
		thisPixelGradient = [ img_Vertical_Gradient(yI,xI) , img_Horizontal_Gradient(yI,xI) ]; %Row vector
		maxInnerProduct1 = 0;%目前為止發現最大的InnerProduct
		maxInnerProduct2 = 0;

		for dirI = 1:4
			
			thisDirForInnerProduct = [ dirs(dirI,1) ; dirs(dirI,2) ]; %Column vector
			thisInnerProduct = abs( norm(thisPixelGradient*thisDirForInnerProduct) / norm(thisDirForInnerProduct) );
			
			%這個比最大還大:最大變第二大，這個變最大
			if thisInnerProduct > maxInnerProduct1
				maxInnerProduct2 = maxInnerProduct1;
				maxInnerProduct1 = thisInnerProduct;
				
				edgeTan2( yI, xI ) = edgeTan1( yI, xI );
				edgeTan1( yI, xI ) = tans(dirI);
			
			elseif thisInnerProduct > maxInnerProduct2
				maxInnerProduct2 = thisInnerProduct;
				edgeTan2( yI, xI ) = tans(dirI);
				
			end
			%這個介於最大和第二大之間:這個變第二大
			
		end

	end
end

%edgeTan1(200, 200:210)
%edgeTan2(200, 200:210)

edgeDir1 = [ 0 0 1 1 2 2 3 3 4 4 ];
edgeDir2 = [ 0 0 1 1 2 2 3 3 4 4 ];
for tI = 0 : 4
	edgeDir1(tI*2+2) = length( edgeTan1(edgeTan1==tI) );
	edgeDir2(tI*2+2) = length( edgeTan2(edgeTan2==tI) );
end
edgeDir1;
edgeDir2;