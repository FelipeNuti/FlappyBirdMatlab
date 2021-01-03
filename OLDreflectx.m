%Reflects a shape S about the x axis
%Felipe Nuti
function S_ref = reflectx(S)
T = [1 0; 0 -1]; %use of a reflection matrix
S_ref = T * S;
