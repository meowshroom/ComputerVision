function [ Q, R ] = QR_Decomp( A )
% This function use Gram-Schmidt decomposition
% to get Q and R for an input matrix.

[m,n] = size(A);
Q = zeros(m,n); %�@�߲�basis
R = zeros(n,n); %�C��Column�O��Ӫ��V�q��Column���A�U����basis�Ҧ������q
%Q�OOrthomormal���@�߲�basis�A�]���V�q�򥦤��n�N�����O�u�����j�p�v
%�A�i�H�Q���A�@�������M1���J����ƾ����n�A�N�o��u�o�������̶�ƾ����t�q(��쬰���J)�v�A�O��R(1, J)
%�M�� �@������ - �o�������̶�ƾ����t�q�A�N�O�u�o�������h����ƾ��᪺�G��(�G��A)�v
%���ۡA�A��G��A�M1���J�����G�����n�A�u�N�o��G��A�̨��G�����t�q(��쬰���J)�v�A�O��R(2, J)
%�̫�A�|�o��o�������̥h���W�z����@�زK�[���A�ұo���G��A�٬��G��J�A��@���J���G��J�@��basis J
%�p���A�N�o��o�������̪��w���K�[�����t�q�AR(1:J-1, J)�A�H�Τ��ݩ�W�z����@�زK�[�����G�骺�qR(J, J)
%�U�@�����J�O�����A���M�W���������J�O�����@�˪����Ѱʧ@�A�o��U�K�[�����t�q�A���h�Ҧ��w�����K�[����A�o��G��J+1
%�A�i�H�o�{�L�k�βզ������������Ӳզ����J�O�����A�]�����h�F���J�O�A�Ybasis J+1
%�t�q�i�H�O�t��
%�����νL�l�ܡA�����̨�

for j = 1:n
	v = A(:,j); %�C����A���@��Column
	for i = 1 : j-1 %�C���Av�������hA(:,j)���A���e��basis�������A�p���Av�N�M���e��basis������
		R(i,j) = Q(:,i)' * A(:,j); %R(i,j)�� �V�qQ(:,i) �M �V�qA(:,j) ���n�����G�A�� �V�qA(:,j) ���A���e��basis�Ҧ������q
		v = v - R(i,j) * Q(:,i); %v���h
	end
	R(j,j) = norm(v); %R(1-j-1,j)�O �V�qA(:,j) ���A���e��basis�Ҧ������q�AR(j,j)�h�O �V�qA(:,j) ���Av�Ҧ������q�A�Yv������
	Q(:,j) = v/R(j,j); %�Nv(�M���e��basis������)�ର���V�q�A�����o��iteration�һs�y���s��basis
end

end

