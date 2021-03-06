% part2 Camera Calibration using 2D calibration object

homogrid = [1,1,1; 270,1,1; 270,210,1; 1,210,1];

im1 = imread('images2.png');
figure();
imshow(im1);
[x,y] = ginput(4);
homoimage = [x,y,ones(4,1)];
H1 = homography2d(homogrid',homoimage')

im2 = imread('images9.png');
figure();
imshow(im2);
[x,y] = ginput(4);
homoimage = [x,y,ones(4,1)];
H2 = homography2d(homogrid',homoimage')

im3 = imread('images12.png');
figure();
imshow(im3);
[x,y] = ginput(4);
homoimage = [x,y,ones(4,1)];
H3 = homography2d(homogrid',homoimage')

im4 = imread('images20.png');
figure();
imshow(im4);
[x,y] = ginput(4);
homoimage = [x,y,ones(4,1)];
H4 = homography2d(homogrid',homoimage')


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

% now compute extrinsic parameters R = [r1 r2 r3] and t
% for each image H1,H2,H3,H4, compute the extrinsic parameters
[R1 t1] = getExtrinsic(H1,A);
[R2 t2] = getExtrinsic(H2,A);
[R3 t3] = getExtrinsic(H3,A);
[R4 t4] = getExtrinsic(H4,A);

% output R and t
R1 = R1
t1 = t1
R2 = R2
t2 = t2
R3 = R3
t3 = t3
R4 = R4
t4 = t4

% compute and output R'R
RTR1 = R1'*R1
RTR2 = R2'*R2
RTR3 = R3'*R3
RTR4 = R4'*R4

% calculate and output new R and R'R
[U1,Sigma1,V1] = svd(R1);
new_R1 = U1 * V1'
newRTR1 = new_R1' * new_R1

[U2,Sigma2,V2] = svd(R2);
new_R2 = U2 * V2'
newRTR2 = new_R2' * new_R2

[U3,Sigma3,V3] = svd(R3);
new_R3 = U3 * V3'
newRTR3 = new_R3' * new_R3

[U4,Sigma4,V4] = svd(R4);
new_R4 = U4 * V4'
newRTR4 = new_R4' * new_R4

%% improve accuracy
% first we need to get the 3d locations of the grid corners. In total, we
% have 10(width) * 8(height) grid corners. We can get the 3d locations of
% grid corners by manually calculating
Xarray = 0:30:270;

Corners = zeros(3,80);
Corners(3,:) = ones(1,80);

for i=1:8
    Corners(1,(i-1)*10+1:10*i) = Xarray;
    Corners(2,(i-1)*10+1:10*i) = 30*(i-1);
end

% get new corners from H1
p_approx1 = zeros(3,80);    
p_approx1 = H1*Corners;
temp = repmat(p_approx1(3,:),[3,1]);
p_approx1 = p_approx1./temp;
% create image and display the approximate grid locations
figure();
imshow(im1);
title('Projected grid corners');
hold on
plot(p_approx1(1,:),p_approx1(2,:),'o');
hold off;

% get new corners from H2
p_approx2 = zeros(3,80);    
p_approx2 = H2*Corners;
temp = repmat(p_approx2(3,:),[3,1]);
p_approx2 = p_approx2./temp;
% create image and display the approximate grid locations
figure();
imshow(im2);
title('Projected grid corners');
hold on
plot(p_approx2(1,:),p_approx2(2,:),'o');
hold off;

% get new corners from H3
p_approx3 = zeros(3,80);    
p_approx3 = H3*Corners;
temp = repmat(p_approx3(3,:),[3,1]);
p_approx3 = p_approx3./temp;
% create image and display the approximate grid locations
figure();
imshow(im3);
title('Projected grid corners');
hold on
plot(p_approx3(1,:),p_approx3(2,:),'o');
hold off;

% get new corners from H4
p_approx4 = zeros(3,80);    
p_approx4 = H4*Corners;
temp = repmat(p_approx4(3,:),[3,1]);
p_approx4 = p_approx4./temp;
% create image and display the approximate grid locations
figure();
imshow(im4);
title('Projected grid corners');
hold on
plot(p_approx4(1,:),p_approx4(2,:),'o');
hold off;

% now use getHarris function to get new H matrix and images
[H1_new p1_correct] = getHarris(im1, p_approx1, Corners);
[H2_new p2_correct] = getHarris(im2, p_approx2, Corners);
[H3_new p3_correct] = getHarris(im3, p_approx3, Corners);
[H4_new p4_correct] = getHarris(im4, p_approx4, Corners);

% now use getKRt function to calculate the new K and new R,t for each image
[new_K,new_R1,new_R2,new_R3,new_t1,new_t2,new_t3] = getKRt(H1_new,H2_new,H3_new,H4_new);

% calculate reprojection errors and its previous result without improvement
[err_reprojection_old1 err_reprojection_new1] = getError(H1_new, Corners, p_approx1, p1_correct);

[err_reprojection_old2 err_reprojection_new2] = getError(H2_new, Corners, p_approx2, p2_correct);

[err_reprojection_old3 err_reprojection_new3] = getError(H3_new, Corners, p_approx3, p3_correct);

[err_reprojection_old4 err_reprojection_new4] = getError(H4_new, Corners, p_approx4, p4_correct);

