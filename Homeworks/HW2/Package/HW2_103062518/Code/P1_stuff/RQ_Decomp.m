function [ R, Q ] = RQ_Decomp( A )
% With QR decomposition, we can easily achieve RQ decomposition

[m n]=size(A);

[Q, R] = QR_Decomp( flipud(A)' );

R = flipud( R' );
R( :,1:m ) = R( : , m: -1: 1 );

Q = Q';
Q(1:m,:) = Q(m:-1:1,:);

end