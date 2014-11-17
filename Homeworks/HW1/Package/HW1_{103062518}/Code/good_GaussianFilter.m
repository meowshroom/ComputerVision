function filteredImage =  good_GaussianFilter( img, filterSize, sigma)
%% Create 6 Blurred images, for filter size = 11 ceil(11/2) = 6
h = size(img,1);		w = size(img,2);

gFilter = fspecial('gaussian', [filterSize filterSize], sigma);

%% First : Filter it
filteredImage = imfilter(img, gFilter, 'same');

%% 亮度補償 at edges : 如果是大小11*11的Filter，那麼邊緣5個pixel有問題
false_lines = (filterSize-1)/2;

%邊緣的亮度補償

for edgeI = 1 : false_lines
	% 計算這個錯誤的Filter的亮度和
	gFilter_edge = gFilter( 1:filterSize, 1:filterSize-false_lines+edgeI-1 );
	gFilter_edge_intensity_sum = sum(sum(gFilter_edge));
	
	filteredImage( edgeI, false_lines+1 : w-false_lines ) = ...
	filteredImage( edgeI, false_lines+1 : w-false_lines )/gFilter_edge_intensity_sum; %上
	
	filteredImage( h-edgeI+1, false_lines+1 : w-false_lines ) = ...
	filteredImage( h-edgeI+1, false_lines+1 : w-false_lines )/gFilter_edge_intensity_sum; %下

	filteredImage( false_lines+1 : h-false_lines, edgeI ) = ...
	filteredImage( false_lines+1 : h-false_lines, edgeI )/gFilter_edge_intensity_sum; %左

	filteredImage( false_lines+1 : h-false_lines, w-edgeI+1 ) = ...
	filteredImage( false_lines+1 : h-false_lines, w-edgeI+1 )/gFilter_edge_intensity_sum; %右

end

%角落的亮度補償
for cornerX = 1 : false_lines
	for cornerY = 1 : false_lines
		% 計算這個錯誤的Filter的亮度和
		gFilter_corner = gFilter( 1:filterSize-false_lines+cornerX-1, 1:filterSize-false_lines+cornerY-1 );
		gFilter_corner_intensity_sum = sum(sum(gFilter_corner));
		
		filteredImage( cornerY, cornerX ) = ...
		filteredImage( cornerY, cornerX )/gFilter_corner_intensity_sum; %左上角
		
		filteredImage( h-cornerY+1, cornerX ) = ...
		filteredImage( h-cornerY+1, cornerX )/gFilter_corner_intensity_sum; %左下角
	
		filteredImage( cornerY, w-cornerX+1 ) = ...
		filteredImage( cornerY, w-cornerX+1 )/gFilter_corner_intensity_sum; %右上角
	
		filteredImage( h-cornerY+1, w-cornerX+1 ) = ...
		filteredImage( h-cornerY+1, w-cornerX+1 )/gFilter_corner_intensity_sum; %右下角
	end
end