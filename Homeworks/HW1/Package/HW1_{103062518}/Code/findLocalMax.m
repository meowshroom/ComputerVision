function localMax =  findLocalMax ( img ) %input�OGradient Image

%��XGradient�����u��V

h = size(img,1);		w = size(img,2);
localMax = zeros( h, w );

% 0:�S��Gradient 1:�W�U 2:���k 3:�k�W���U 4:���W�k�U

dirs = [	0,1;0,-1;		1,0; -1,0;		1,1; -1,-1;		-1,1; 1,-1   ];

for yI = 2 : h-1
	for xI = 2 : w-1
		
		greater = 0;%�o�I��Gradient���L�I���٭n�j�A8�Y��Ҧ��I���j�A7�Y�񵴤j�����I���j
		
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
