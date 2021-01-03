%Operates a translation of (a, b) on a 2D shape S
%Felipe Nuti

function S_t = translate(S, a, b)
v = [a;b]; %make use of automatic broadcasting to add a to the x coordinates and b to the y coordinates
S_t = S + v;