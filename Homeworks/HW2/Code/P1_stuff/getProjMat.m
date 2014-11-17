function [ data_X_Homo, data_x_Homo, projMat, x_proj, sse ] = getProjMat( data_X, data_x )

n = size(data_X, 2);

%% Turn Cartesian Coords into Homogeneous Coords System
data_X_Homo = data_X;
data_X_Homo (4, :)=1;
data_x_Homo = data_x;
data_x_Homo (3, :)=1;

%% Generate A, such ap = 0
%盢AだΘ3场だ: 计︽(x㎝3D翴闽玒)案计︽(y㎝3D翴闽玒)
A_OddLeft = data_X_Homo' ;
A_OddMid = zeros(n, 4) ;
A_OddRight = - (data_X_Homo') .* repmat( data_x_Homo(1,:)' , [1, 4] );
A_Odd = [ A_OddLeft, A_OddMid, A_OddRight ];

A_EvenLeft = A_OddMid ;
A_EvenMid = A_OddLeft ;
A_EvenRight = - (data_X_Homo') .* repmat( data_x_Homo(2,:)' , [1, 4] );
A_Even = [ A_EvenLeft, A_EvenMid, A_EvenRight ];

%Interleave A_Odd and A_Even
A = reshape( [A_Odd(:), A_Even(:)]', 2*n, []);

%% Use SVD
[U,S,V] = svd(A);
projMat_LONG = V(:, 12) ;

projMat = reshape( projMat_LONG, [4,3] )' ;
x_proj = projMat * data_X_Homo;
x_proj(1,:) = x_proj(1,:) ./ x_proj(3,:) ;
x_proj(2,:) = x_proj(2,:) ./ x_proj(3,:) ;
x_proj(3,:) = x_proj(3,:) ./ x_proj(3,:) ;

sse = norm( x_proj(1:2, :) - data_x ) ^2 ;

end