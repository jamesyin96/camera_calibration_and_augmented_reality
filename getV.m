% tHis function is to get tHe tHe V of Vb = 0
% tHe input is H, tHe HomograpHy of a image
function result = getV(H)
% get v12
H = H';
% v(i,j) = [h(i,1)*h(j,1),h(i,1)*h(j,2)+h(i,2)*h(j,1),h(i,2)*h(j,2),h(i,3)*h(j,1)+h(i,1)*h(j,3),h(i,2)*h(j,3)+h(i,3)*h(j,2),h(i,3)*h(j,3)];
i = 1; j = 2;
v12 = [H(i,1)*H(j,1),H(i,1)*H(j,2)+H(i,2)*H(j,1),H(i,2)*H(j,2),H(i,3)*H(j,1)+H(i,1)*H(j,3),H(i,2)*H(j,3)+H(i,3)*H(j,2),H(i,3)*H(j,3)];
i = 1; j = 1;
% get v11
v11 = [H(i,1)*H(j,1),H(i,1)*H(j,2)+H(i,2)*H(j,1),H(i,2)*H(j,2),H(i,3)*H(j,1)+H(i,1)*H(j,3),H(i,2)*H(j,3)+H(i,3)*H(j,2),H(i,3)*H(j,3)];
% get v22
i = 2; j = 2;
v22 = [H(i,1)*H(j,1),H(i,1)*H(j,2)+H(i,2)*H(j,1),H(i,2)*H(j,2),H(i,3)*H(j,1)+H(i,1)*H(j,3),H(i,2)*H(j,3)+H(i,3)*H(j,2),H(i,3)*H(j,3)];

result = [v12; v11-v22];
end