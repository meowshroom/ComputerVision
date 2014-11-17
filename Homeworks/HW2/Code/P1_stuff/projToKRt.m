function [ K, R, t ] = projToKRt( projMat )

KR = projMat ( 1:3, 1:3 );
Kt =  projMat ( 1:3, 1:4 );


end