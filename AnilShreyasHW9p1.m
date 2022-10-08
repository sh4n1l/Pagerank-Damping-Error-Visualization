A = readmatrix("AdjacencyMatrix.txt");
S = [];
for col = [1:500]
    vec = A(:,col);
    mySum = sum(vec);
    for row = [1:500]
        if mySum == 0
            S(row,col) = 1/size(vec);
        else
            S(row,col) = vec(row)/mySum;
        end
    end
end

alpha = [0.25:0.25:1];
pk1(:,1) = ones(500,1) .* (1/500);
pk2(:,1) = ones(500,1) .* (1/500);
pk3(:,1) = ones(500,1) .* (1/500);
pk4(:,1) = ones(500,1) .* (1/500);
J = ones(500);
Gm1 = alpha(1) .* S + ((1-alpha(1))/500).*J;
Gm2 = alpha(2) .* S + ((1-alpha(2))/500).*J;
Gm3 = alpha(3) .* S + ((1-alpha(3))/500).*J;
Gm4 = alpha(4) .* S + ((1-alpha(4))/500).*J;

for k = [1:10]
    pk1(:,k+1) = Gm1 * pk1(:,k);
    pk2(:,k+1) = Gm2 * pk2(:,k);
    pk3(:,k+1) = Gm3 * pk3(:,k);
    pk4(:,k+1) = Gm4 * pk4(:,k);
end
v1=zeros(10,1);
v2=zeros(10,1);
v3=zeros(10,1);
v4=zeros(10,1);
for n = [1:10]
    v1(n,:)=TVdist(pk1(:,n+1),pk1(:,n));
    v2(n,:)=TVdist(pk2(:,n+1),pk2(:,n));
    v3(n,:)=TVdist(pk3(:,n+1),pk3(:,n));
    v4(n,:)=TVdist(pk4(:,n+1),pk4(:,n));
end
i = [1:10];
semilogy(i,v1, 'r')
hold on
semilogy(i,v2, 'g')
semilogy(i,v3, 'b')
semilogy(i,v4, 'k')
legend('alpha=0.25','alpha=0.5','alpha=0.75','alpha=1.0')
hold off
format long
TVdist(pk1(:,end),pk4(:,end)) * 100
TVdist(pk2(:,end),pk4(:,end)) * 100
TVdist(pk3(:,end),pk4(:,end)) * 100


