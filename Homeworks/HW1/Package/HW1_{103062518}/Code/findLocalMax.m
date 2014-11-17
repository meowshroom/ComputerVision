function localMax =  findLocalMax ( img ) %input琌Gradient Image

%тGradientち絬よ

h = size(img,1);		w = size(img,2);
localMax = zeros( h, w );

% 0:⊿ΤGradient 1: 2:オ 3:オ 4:オ

dirs = [	0,1;0,-1;		1,0; -1,0;		1,1; -1,-1;		-1,1; 1,-1   ];

for yI = 2 : h-1
	for xI = 2 : w-1
		
		greater = 0;%硂翴Gradientゑㄤ翴常临璶8ゑ┮Τ翴常7ゑ荡场だ翴常
		
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
