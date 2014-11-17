function [ lbp ] = getLBP( img, equal01 )

%8個基本方向，從「左上」開始，順時針喵一圈
patchShiftDirs = [ -1,-1; -1,0; -1,1;	 0,1;	 1,1; 1,0; 1,-1;	0,-1;  ];

[ h, w ] = size(img);
img_Center = img( 2:h-1, 2:w-1 );%去掉最邊緣的pixel，LBP只有中間的pixel的有值
img_Center_lbp = zeros ( h-2, w-2 );%和thisImg_Center一樣大

for dirI = 1 : 8
	yStart = 2  + patchShiftDirs(dirI, 1);
	yEnd = h-1+ patchShiftDirs(dirI, 1);
	xStart = 2  + patchShiftDirs(dirI, 2);
	xEnd = w-1+ patchShiftDirs(dirI, 2);
	
	shiftedPatch = img( yStart:yEnd , xStart:xEnd );
	diffs = shiftedPatch - img_Center;
	diffs_Hashbit = sign(diffs); %大於是1，小於是0
	diffs_Hashbit( shiftedPatch==img_Center )=equal01;%等於是1
	diffs_Hashbit( diffs_Hashbit<0 )=0;
	
	%加進lbp中
	img_Center_lbp = img_Center_lbp *2 + double(diffs_Hashbit);
end

lbp = img_Center_lbp;

end

