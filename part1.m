% the part 1: Camera Calibration using 3D calibration object

% 1, the cubevertices
cubeposition = [2 2 2; -2 2 2; -2 2 -2; 2 2 -2; 2 -2 2; -2 -2 2; -2 -2 -2; 2 -2 -2]';
cameraposition = [422 323;178 323;118 483; 482 483; 438 73; 162 73; 78 117;522 117]';
plot(cameraposition(:,1),cameraposition(:,2),'o');

% get homogeneous coordinates of cube corner and camera image
temp = size(cubeposition);
homocube = [cubeposition; ones(1,temp(2))];
temp1 = size(cameraposition);
homocamera = [cameraposition; ones(1,temp1(2))];

% 3, use the getP function to generate the big P matrix 16x12
P = zeros(16,12);
for i = 1:8
    P(2*i-1:2*i,:) = getP(homocube(:,i),homocamera(:,i));
end
% output the big matrix P
P

% 4
[U,S,V] = svd(P);
% the last column vector of V should be 12 elements in row order of the M
tempM = V(:,12);
M = reshape(tempM,4,3)';
% output the matrix M
M

% 5
[U1,Sigma,V1] = svd(M);
homocameracenter = V1(:,4)/V1(4,4);
% show the corresponding 3 Euclidean coordinates of the camera center
homocameracenter(1:3,:)

% 6
M1 = M(:,1:3);
M1 = M1 * (1/M(3,3))

% 7
cosx = M1(3,3)/sqrt(M1(3,3)^2+M1(3,2)^2);
sinx = -M1(3,2)/sqrt(M1(3,3)^2+M1(3,2)^2);
% output Rx, N and Thetax
Rx = [1,0,0;0,cosx,-sinx;0,sinx,cosx]
N = M1*Rx
Thetax = (asin(sinx) + 2*pi)*(180/pi)

% 8
Rz = [cosz,-sinz,0;sinz,cosz,0;0,0,1]

% 9. M1=K * Rz' * Rx', so K = M1 * (Rx')^-1 * (Rz')^-1
K = M1 * (Rx')^(-1) * (Rz')^(-1);
% rescale so that K(3,3)=1
K = K/K(3,3)


