function nms = non_maximal_suppersion  ( img, firstThreshold, secondThreshold, seeds )

h = size(img,1);		w = size(img,2);

%你應該往哪裡找 0:沒有Gradient 1:上下 2:左右 3:右上左下 4:左上右下
[edgeTan1, edgeTan2] = edgeTangent ( img );

nextPoints = [ 1,0; -1,0;		0,1 ; 0,-1;		-1,1;1,-1;		1,1;-1,-1];

img_gradient = sobelFilter( img );

%seeds，起始的那些點
seeds(img_gradient<firstThreshold) =0;
nms = seeds;

%% BFS initial Queue
[row,col] = find( seeds );
seedPosition = [row,col];

%已經被找過的點(H*W)
visited = seeds; %1為已經找過了


%預先宣告記憶體
queueToSearch = zeros( h*w, 2 );

%等待被尋找的點( N*2 )
queueToSearch = [ seedPosition; queueToSearch];

%現在正在尋找的點的Index
queueIndex = 1;

%Queue尾端的Index
lastIndex = size(seedPosition,1);

%對每個等待被尋找的點...
while queueIndex<length(queueToSearch);
	
	thisPoint = queueToSearch(queueIndex,:);
	
	%檢查邊緣切線方向的兩個點
	thisTan1 = edgeTan1( thisPoint(1), thisPoint(2) );
	thisTan2 = edgeTan2( thisPoint(1), thisPoint(2) );
	if thisTan1 == 0 %如果是0就不要
		queueIndex = queueIndex +1;
		continue;
	end
	
	nextpoint1 = [ thisPoint + nextPoints( thisTan1*2-1,:) ];
	nextpoint2 = [ thisPoint + nextPoints( thisTan1*2-0,:) ];
	
	%如果它的Gradient夠大，就塞進Queue，並且nms=1
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
	
	if thisTan2 == 0 %如果是0就不要
		queueIndex = queueIndex +1;
		continue;
	end
	
	nextpoint3 = [ thisPoint + nextPoints( thisTan2*2-1,:) ];
	nextpoint4 = [ thisPoint + nextPoints( thisTan2*2-0,:) ];
	%如果它的Gradient夠大，就塞進Queue，並且nms=1
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
