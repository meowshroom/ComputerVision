function [ rotated_LBP ] = rotateLBP( lbp )
[ h, w ] = size(lbp);

%僅定義大小
rotated_LBP = lbp;

%產生歸類表
mappingTable = uint16( zeros( 256, 1 ) );
rotatedValues=zeros(8,1);

%1~256表示0~255，用的時候要+1
for byteI = 0 : 255
	bitString = uint16( byteI*256 + byteI );
	
	for rotI=1:8
		rotatedValues(rotI) = bitshift( bitString, rotI, 'uint16' )/256;
	end
	
	minRotatedValues = min(rotatedValues);
	
	mappingTable(byteI+1,1) = minRotatedValues;
end

%進行歸類
for yI = 1 : h
	for xI = 1 : w
		rotated_LBP(yI, xI) = mappingTable( lbp(yI, xI)+1 );
	end
end



end

