function localMax =  findLocalMax ( img ) %input是Gradient Image

%找出Gradient的切線方向

h = size(img,1);		w = size(img,2);
localMax = zeros( h, w );

% 0:沒有Gradient 1:上下 2:左右 3:右上左下 4:左上右下

dirs = [	0,1;0,-1;		1,0; -1,0;		1,1; -1,-1;		-1,1; 1,-1   ];

for yI = 2 : h-1
	for xI = 2 : w-1
		
		greater = 0;%這點的Gradient比其他點都還要大，8即比所有點都大，7即比絕大部分點都大
		
		for dirI = 1:8
			if img(yI,xI) > img( yI+dirs(dirI,1) , xI+dirs(dirI,2) )
				greater = greater +1;
			else
				break;
			end
		end
		
		if greater >= 8
			localMax( yI, xI ) =1;
		end
		
	end
end
