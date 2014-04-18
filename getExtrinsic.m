% this function takes H and A as input parameters, the output should be the
% extrinsic parameters of the image
function [R t] = getExtrinsic(H,A)
lambda = 1/(sqrt(sum( (A^(-1)*H(:,1)).^2 )));
r1 = lambda * A^(-1) * H(:,1);
r2 = lambda * A^(-1) * H(:,2);
r3 = cross(r1,r2);
t = lambda * A^(-1) * H(:,3);
R = [r1 r2 r3];
end