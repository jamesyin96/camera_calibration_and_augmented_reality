% this function can get the K,R and t from H matrix
function [K,R1,R2,R3,t1,t2,t3] = getKRt(H1,H2,H3,H4)

% Now compute the intrinsic and extrinsic parameters
V1 = getV(H1);
V2 = getV(H2);
V3 = getV(H3);
V4 = getV(H4);

V = [V1;V2;V3;V4];

[U,S,V] = svd(V);
b = V(:,6);
% b = [b11,b12,b22,b13,b23,b33]'
B = [b(1) b(2) b(4);b(2) b(3) b(5);b(4) b(5) b(6)];

% v0 = (B12 * B13 - B11 * B23)/(B11 * B22 - B12 * B12)
% lambda  = B33 - [B13^2 + v0*(B12*B13 - B11*B23)]/B11
% alpha = sqrt(lambda/B11)
% beta = sqrt(lambda*B11/(B11*B22-B12^2))
% gamma = -B12*alpha^2*beta/lambda
% u0 = gamma*v0/alpha - B13*alpha^2/lambda
v0 = (B(1,2)*B(1,3) - B(1,1)*B(2,3))/(B(1,1)*B(2,2) - B(1,2)^2);
lambda  = B(3,3) - (B(1,3)^2 + v0*(B(1,2)*B(1,3) - B(1,1)*B(2,3)))/B(1,1);
alpha = sqrt(lambda/B(1,1));
beta = sqrt(lambda*B(1,1)/(B(1,1)*B(2,2)-B(1,2)^2));
gamma = -B(1,2)*alpha^2*beta/lambda;
u0 = gamma*v0/alpha - B(1,3)*alpha^2/lambda;

% Intrinsic parameters
% A=[alpha gamma u0
%    0     beta  v0
%    0     0     1]
A = [alpha gamma u0; 0 beta v0; 0 0 1];
K = A*A';
% now compute extrinsic parameters R = [r1 r2 r3] and t
% for each image H1,H2,H3,H4, compute the extrinsic parameters
[R1 t1] = getExtrinsic(H1,A);
[R2 t2] = getExtrinsic(H2,A);
[R3 t3] = getExtrinsic(H3,A);
[R4 t4] = getExtrinsic(H4,A);

end