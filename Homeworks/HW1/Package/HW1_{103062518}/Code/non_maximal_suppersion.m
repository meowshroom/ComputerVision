function nms = non_maximal_suppersion  ( img, firstThreshold, secondThreshold, seeds )

h = size(img,1);		w = size(img,2);

%�A���ө����̧� 0:�S��Gradient 1:�W�U 2:���k 3:�k�W���U 4:���W�k�U
[edgeTan1, edgeTan2] = edgeTangent ( img );

nextPoints = [ 1,0; -1,0;		0,1 ; 0,-1;		-1,1;1,-1;		1,1;-1,-1];

img_gradient = sobelFilter( img );

%seeds�A�_�l�������I
seeds(img_gradient<firstThreshold) =0;
nms = seeds;

%% BFS initial Queue
[row,col] = find( seeds );
seedPosition = [row,col];

%�w�g�Q��L���I(H*W)
visited = seeds; %1���w�g��L�F


%�w���ŧi�O����
queueToSearch = zeros( h*w, 2 );

%���ݳQ�M�䪺�I( N*2 )
queueToSearch = [ seedPosition; queueToSearch];

%�{�b���b�M�䪺�I��Index
queueIndex = 1;

%Queue���ݪ�Index
lastIndex = size(seedPosition,1);

%��C�ӵ��ݳQ�M�䪺�I...
while queueIndex<length(queueToSearch);
	
	thisPoint = queueToSearch(queueIndex,:);
	
	%�ˬd��t���u��V������I
	thisTan1 = edgeTan1( thisPoint(1), thisPoint(2) );
	thisTan2 = edgeTan2( thisPoint(1), thisPoint(2) );
	if thisTan1 == 0 %�p�G�O0�N���n
		queueIndex = queueIndex +1;
		continue;
	end
	
	nextpoint1 = [ thisPoint + nextPoints( thisTan1*2-1,:) ];
	nextpoint2 = [ thisPoint + nextPoints( thisTan1*2-0,:) ];
	
	%�p�G����Gradient���j�A�N��iQueue�A�åBnms=1
	if img_gradient(nextpoint1(1), nextpoint1(2))>secondThreshold && visited(nextpoint1(1), nextpoint1(2)) == 0
		nms(nextpoint1(1), nextpoint1(2)) = 1;
		lastIndex = lastIndex +1;
		queueToSearch(lastIndex, :)=nextpoint1(:);%enQueue
	end
	visited(nextpoint1(1), nextpoint1(2)) = 1;
	
	if img_gradient(nextpoint2(1), nextpoint2(2))>secondThreshold && visited(nextpoint2(1), nextpoint2(2)) == 0
		nms(nextpoint2(1), nextpoint2(2)) = 1;
		lastIndex = lastIndex +1;
		queueToSearch(lastIndex, :)=nextpoint2(:);%enQueue
	end
	visited(nextpoint2(1), nextpoint2(2)) = 1;
	
	if thisTan2 == 0 %�p�G�O0�N���n
		queueIndex = queueIndex +1;
		continue;
	end
	
	nextpoint3 = [ thisPoint + nextPoints( thisTan2*2-1,:) ];
	nextpoint4 = [ thisPoint + nextPoints( thisTan2*2-0,:) ];
	%�p�G����Gradient���j�A�N��iQueue�A�åBnms=1
	if img_gradient(nextpoint3(1), nextpoint3(2))>secondThreshold && visited(nextpoint3(1), nextpoint3(2)) == 0
		nms(nextpoint3(1), nextpoint3(2)) = 1;
		lastIndex = lastIndex +1;
		queueToSearch(lastIndex, :)=nextpoint3(:);%enQueue
	end
	visited(nextpoint3(1), nextpoint3(2)) = 1;
	
	if img_gradient(nextpoint4(1), nextpoint4(2))>secondThreshold && visited(nextpoint4(1), nextpoint4(2)) == 0
		nms(nextpoint4(1), nextpoint4(2)) = 1;
		lastIndex = lastIndex +1;
		queueToSearch(lastIndex, :)=nextpoint4(:);%enQueue
	end
	visited(nextpoint4(1), nextpoint4(2)) = 1;
	
	
	
	queueIndex = queueIndex +1;
	if queueIndex>=lastIndex
		break;
	end
	
end
