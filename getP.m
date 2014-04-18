% this function takes as argument the homogeneous coordinates of one cube
% corner and the homogeneous coordinates of its image, and returns 2 rows
% of the matrix P
function result = getP(cubecoordinate, imagecoordinate)

% get normal coordinates of cube and image
cubecoordinate = cubecoordinate/cubecoordinate(4);
imagecoordinate = imagecoordinate/imagecoordinate(3);

T0 = zeros(1,4);
P1 = [cubecoordinate',T0,-imagecoordinate(1)*cubecoordinate'];
P2 = [T0,cubecoordinate',-imagecoordinate(2)*cubecoordinate'];

result = [P1;P2];