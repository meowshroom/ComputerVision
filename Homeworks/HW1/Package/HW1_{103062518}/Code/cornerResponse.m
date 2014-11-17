function [ cornerResponseImage ] = cornerResponse( smallEigenValue, bigEigenValue, k )
%CORNERRESPONSE Summary of this function goes here
%   Detailed explanation goes here

detA =		smallEigenValue .* bigEigenValue ;
traceA2= (smallEigenValue + bigEigenValue) .^2 ;

cornerResponseImage = detA - k*traceA2;

end

