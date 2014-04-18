% this function calculates the err_reprojection and its previous result

function [err_old err] = getError(H_new, Corners, p_approx, p_correct)
% calculate new p_approx
p_approx_new = H_new * Corners;
temp = repmat(p_approx_new(3,:),[3,1]);
p_approx_new = p_approx_new./temp;
% calculate the distance matrix
D = dist2(p_correct,p_approx(1:2,:)');
D_new = dist2(p_correct,p_approx_new(1:2,:)');    
%err_reprojection is the sum of the Euclidean distance between all the
%grid points
err_old = sum(sqrt(diag(D)));
err = sum(sqrt(diag(D_new)));
end