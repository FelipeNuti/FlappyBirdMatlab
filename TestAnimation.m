% Tests animation that rotates and plots an arrow about (1.5, -4) n times
% Felipe Nuti

n = 60;  
a = linspace(0, 2*pi, n+1);  % notice that we need n+1 spaces for n distinct copies to be produced
% Notice also that this could be done without an array, by simply repeating
% the content of the for loop but updating arrow = rotateabout(arrow,
% 2*pi/n,1.5, -4).
arrow = [ 0 1 1 3 3 1 1 0 ; 0 1 0.5 0.5 -0.5 -0.5 -1 0];

for theta = a
    drawshape(rotateabout(arrow, theta, 1.5, -4), 'b')    % Draws the copy
    axis([-10 10 -10 10])                                 % The following commands set up the display of the plot 
    axis square
    drawnow
    pause(0.01)
end