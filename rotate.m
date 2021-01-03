%Rotates a shape S by an anti-clockwise angle a
%Felipe Nuti
function S_rot = rotate(S, a)
T = [cos(a) -sin(a); sin(a) cos(a)];%use of a reflection matrix
S_rot = T * S;

