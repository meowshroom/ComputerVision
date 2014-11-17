function filteredImage =  good_GaussianFilter( img, filterSize, sigma)
%% Create 6 Blurred images, for filter size = 11 ceil(11/2) = 6
h = size(img,1);		w = size(img,2);

gFilter = fspecial('gaussian', [filterSize filterSize], sigma);

%% First : Filter it
filteredImage = imfilter(img, gFilter, 'same');

%% �G�׸��v at edges : �p�G�O�j�p11*11��Filter�A������t5��pixel�����D
false_lines = (filterSize-1)/2;

%��t���G�׸��v

for edgeI = 1 : false_lines
	% �p��o�ӿ��~��Filter���G�שM
	gFilter_edge = gFilter( 1:filterSize, 1:filterSize-false_lines+edgeI-1 );
	gFilter_edge_intensity_sum = sum(sum(gFilter_edge));
	
	filteredImage( edgeI, false_lines+1 : w-false_lines ) = ...
	filteredImage( edgeI, false_lines+1 : w-false_lines )/gFilter_edge_intensity_sum; %�W
	
	filteredImage( h-edgeI+1, false_lines+1 : w-false_lines ) = ...
	filteredImage( h-edgeI+1, false_lines+1 : w-false_lines )/gFilter_edge_intensity_sum; %�U

	filteredImage( false_lines+1 : h-false_lines, edgeI ) = ...
	filteredImage( false_lines+1 : h-false_lines, edgeI )/gFilter_edge_intensity_sum; %��

	filteredImage( false_lines+1 : h-false_lines, w-edgeI+1 ) = ...
	filteredImage( false_lines+1 : h-false_lines, w-edgeI+1 )/gFilter_edge_intensity_sum; %�k

end

%�������G�׸��v
for cornerX = 1 : false_lines
	for cornerY = 1 : false_lines
		% �p��o�ӿ��~��Filter���G�שM
		gFilter_corner = gFilter( 1:filterSize-false_lines+cornerX-1, 1:filterSize-false_lines+cornerY-1 );
		gFilter_corner_intensity_sum = sum(sum(gFilter_corner));
		
		filteredImage( cornerY, cornerX ) = ...
		filteredImage( cornerY, cornerX )/gFilter_corner_intensity_sum; %���W��
		
		filteredImage( h-cornerY+1, cornerX ) = ...
		filteredImage( h-cornerY+1, cornerX )/gFilter_corner_intensity_sum; %���U��
	
		filteredImage( cornerY, w-cornerX+1 ) = ...
		filteredImage( cornerY, w-cornerX+1 )/gFilter_corner_intensity_sum; %�k�W��
	
		filteredImage( h-cornerY+1, w-cornerX+1 ) = ...
		filteredImage( h-cornerY+1, w-cornerX+1 )/gFilter_corner_intensity_sum; %�k�U��
	end
end