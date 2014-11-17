function [ Q, R ] = QR_Decomp( A )
% This function use Gram-Schmidt decomposition
% to get Q and R for an input matrix.

[m,n] = size(A);
Q = zeros(m,n); %一貓票basis
R = zeros(n,n); %每個Column是原來的向量的Column中，各對應basis所佔的分量
%Q是Orthomormal的一貓票basis，因此向量跟它內積就直接是「成份大小」
%你可以想像，一罐牛奶和1公克的塑化劑內積，就得到「這罐牛奶裡塑化劑的含量(單位為公克)」，記為R(1, J)
%然後 一罐牛奶 - 這罐牛奶裡塑化劑的含量，就是「這罐牛奶去除塑化劑後的液體(液體A)」
%接著，再把液體A和1公克的防腐劑內積，「就得到液體A裡防腐劑的含量(單位為公克)」，記為R(2, J)
%最後，會得到這罐牛奶裡去除上述任何一種添加物，所得的液體，稱為液體J，把一公克的液體J作為basis J
%如此，就得到這罐牛奶裡的已知添加物的含量，R(1:J-1, J)，以及不屬於上述任何一種添加物的液體的量R(J, J)
%下一罐巧克力牛奶，做和上面那罐巧克力牛奶一樣的分解動作，得到各添加物的含量，除去所有已知的添加物後，得到液體J+1
%你可以發現無法用組成牛奶的成分來組成巧克力牛奶，因為它多了巧克力，即basis J+1
%含量可以是負的
%牛奶用盤子喝，風味最佳

for j = 1:n
	v = A(:,j); %每次取A的一個Column
	for i = 1 : j-1 %每次，v都先除去A(:,j)中，先前的basis的成分，如此，v就和先前的basis都垂直
		R(i,j) = Q(:,i)' * A(:,j); %R(i,j)為 向量Q(:,i) 和 向量A(:,j) 內積的結果，為 向量A(:,j) 中，先前的basis所佔的分量
		v = v - R(i,j) * Q(:,i); %v除去
	end
	R(j,j) = norm(v); %R(1-j-1,j)是 向量A(:,j) 中，先前的basis所佔的分量，R(j,j)則是 向量A(:,j) 中，v所佔的分量，即v的長度
	Q(:,j) = v/R(j,j); %將v(和先前的basis都垂直)轉為單位向量，成為這個iteration所製造的新的basis
end

end

