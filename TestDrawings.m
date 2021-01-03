%Tests drawings
%Felipe Nuti

arrow = [ 0 1 1 3 3 1 1 0 ; 0 1 0.5 0.5 -0.5 -0.5 -1 0];
drawshape(arrow, 'g')

%notice how, for the shape to be closed, the starting point has to be equal to the ending point
%This means that a closed shape with n vertices will be represented by a
%2x(n+1) matrix

%The drawing-a-square part was depracated after reaching exercise 3
%square = [0 1 1 0 0; 0 0 1 1 0];
%drawshape(square, 'g')

drawshape(arrow, 'g')
hold on
arrow = translate(arrow, 2, 3);
drawshape(arrow, 'r')
hold on
arrow = reflect(arrow, 'y');
drawshape(arrow, 'c')
hold on
arrow = reflect(arrow, 'x');
drawshape(arrow, 'm')
arrow = rotate(arrow, pi/4);
drawshape(arrow, 'b')


axis([-10 10 -10 10])
axis square