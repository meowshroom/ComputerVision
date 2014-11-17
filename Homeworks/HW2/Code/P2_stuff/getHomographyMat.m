function [ data_X_Homo, data_x_Homo, projMat ] = getHomographyMat( data_X, data_x )
%���MP1��getProjMat�t���h�A�u�O��X��projMat��3��S���N�q
n = size(data_X, 2);

%% Turn Cartesian Coords into Homogeneous Coords System
data_X_Homo = data_X;
data_X_Homo (3, :)=1; %�b�o��Function�̨S����ڥγ~�A�u�^��

data_X_Homo_3D = data_X;
data_X_Homo_3D (3, :) = 0;
data_X_Homo_3D (4, :) = 1;

data_x_Homo = data_x;
data_x_Homo (3, :)=1;

%% Generate A, such ap = 0
%�NA����3�ӳ���: �_�Ʀ�(x�M3D�I�����Y)�B���Ʀ�(y�M3D�I�����Y)
A_OddLeft = data_X_Homo_3D' ;
A_OddMid = zeros(n, 4) ;
A_OddRight = - (data_X_Homo_3D') .* repmat( data_x_Homo(1,:)' , [1, 4] );
A_Odd = [ A_OddLeft, A_OddMid, A_OddRight ];

A_EvenLeft = A_OddMid ;
A_EvenMid = A_OddLeft ;
A_EvenRight = - (data_X_Homo_3D') .* repmat( data_x_Homo(2,:)' , [1, 4] );
A_Even = [ A_EvenLeft, A_EvenMid, A_EvenRight ];

%Interleave A_Odd and A_Even
A = reshape( [A_Odd(:), A_Even(:)]', 2*n, []);

%% Use SVD
[U,S,V] = svd(A);
projMat_LONG = V(:, 12) ;

projMat = reshape( projMat_LONG, [4,3] )' ;
projMat = [ projMat(:,1:2), projMat(:,4) ];
end