% Rotates a shape S by an anti-clockwise angle a about a point (x, y)
% Felipe Nuti

function S_rota = rotateabout(S, a, x, y)
S = translate(S, -x, -y); % Obtain coordinates about (x, Y)
S = rotate(S, a); % Perform rotation
S = translate(S, x, y); % Return to initial frame
S_rota = S;