function [ lbp ] = getLBP( img, equal01 )

%8�Ӱ򥻤�V�A�q�u���W�v�}�l�A���ɰw�p�@��
patchShiftDirs = [ -1,-1; -1,0; -1,1;	 0,1;	 1,1; 1,0; 1,-1;	0,-1;  ];

[ h, w ] = size(img);
img_Center = img( 2:h-1, 2:w-1 );%�h������t��pixel�ALBP�u��������pixel������
img_Center_lbp = zeros ( h-2, w-2 );%�MthisImg_Center�@�ˤj

for dirI = 1 : 8
	yStart = 2  + patchShiftDirs(dirI, 1);
	yEnd = h-1+ patchShiftDirs(dirI, 1);
	xStart = 2  + patchShiftDirs(dirI, 2);
	xEnd = w-1+ patchShiftDirs(dirI, 2);
	
	shiftedPatch = img( yStart:yEnd , xStart:xEnd );
	diffs = shiftedPatch - img_Center;
	diffs_Hashbit = sign(diffs); %�j��O1�A�p��O0
	diffs_Hashbit( shiftedPatch==img_Center )=equal01;%����O1
	diffs_Hashbit( diffs_Hashbit<0 )=0;
	
	%�[�ilbp��
	img_Center_lbp = img_Center_lbp *2 + double(diffs_Hashbit);
end

lbp = img_Center_lbp;

end

