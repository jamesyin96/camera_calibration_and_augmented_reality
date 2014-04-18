% this function call the harris function and compute the harris corners as
% well as the p_correct.
% the inputs are: image matrix, p_approx
% the outputs are: H_new, harris image and grid points image
function H_new = getHarris(im, p_approx)
% set some parameters
sigma = 2;
thresh = 500;
radius = 2;

% handle image, call harris function
[cim,r,c,rsubp,csubp] = harris(rgb2gray(im),sigma,thresh,radius,1);
p_harris = [csubp,rsubp];
figure();
imshow(im);
title('Harris corners');
hold on
plot(p_harris(:,1),p_harris(:,2),'b+');
hold off
Dist = dist2(p_approx(1:2,:)',p_harris);
[D_sorted, D_index] = sort(Dist,2);
p_correct = p_harris(D_index(:,1),:);
% show the image
figure();
imshow(im);
title('grid points');
hold on    
plot(p_correct(:,1),p_correct(:,2),'r+');
hold off
p_correct_homo = [p_correct,ones(80,1)];
H_new = homography2d(Corners',p_correct_homo');
end