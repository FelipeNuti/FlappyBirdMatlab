clear  % clears workspace variables to avoid bugs

birdShape = [0.6 0.8 1 0.8 0.7 0.1 0 0.1 0.5 0.6;     % polygon designed to resemble a bird
                1 1 0.75 0.75 0 0 0.75 0.6 0.6 1];

% environment variables that can be tweaked for gameplay and
% controllability purposes (self-explanatory names)
global ARENA_LENGTH;
global ARENA_HEIGHT;
global CUTOFF_SPEED;
global GRAVITY;
global SPEED_INCREMENT;
global MAX_REACH;
global GAP_HEIGHT;
global GAP_WIDTH;
global HORIZONTAL_SPEED;
global PIPE_TO_PIPE_DIST;
global STOP;
global RANGE;
global dt;
global THRESH;

ARENA_LENGTH = 30;
ARENA_HEIGHT = 15;
CUTOFF_SPEED = 50;
GRAVITY = 60;
SPEED_INCREMENT = 10;
MAX_REACH = (CUTOFF_SPEED/GRAVITY) * 1 + ((2*ARENA_HEIGHT/GRAVITY)^0.5) * 1;
GAP_HEIGHT = 3;
GAP_WIDTH = 2;
HORIZONTAL_SPEED = 20;
PIPE_TO_PIPE_DIST = 8;
STOP = 2;
RANGE = 2;
dt = 0.01;
THRESH = 1.5;

% instantiation of the "bird" object
color = 'y';
s = shape(birdShape, 'y');
s = s.translateShape([0.5;ARENA_HEIGHT/2]);
global flappyBird;
flappyBird = bird(s, color);
flappyBird.draw();

% FIFO queue of pipes (naive implementation from traditionnal arrays chosen for simplicity)
global pipeArray;
pipe1 = pipe('g');
pipeArray = [pipe1];

% t = 0:1:5/dt;

% button for controlling the y velocity of the bird
btn = uicontrol('Style', 'pushbutton');
btn.Callback = @buttonCallback;
btn.String = "FLY!";
btn.Position = [20 40 60 20];

% button for quitting the game
stopBtn = uicontrol('Style', 'pushbutton');
stopBtn.Callback = @stopButtonCallback;
stopBtn.String = "QUIT";

% waits for the player to hit the "fly" button to start the game
while STOP == 2
    drawnow
end

% gameplay loop
while STOP == 0
    if flappyBird.v(2) > -CUTOFF_SPEED      % if the bird is above the downward terminal velocity, apply gravitational acceleration
        flappyBird = flappyBird.incrementVelocity(flappyBird.v(2)-GRAVITY * dt);
    end
    
    % update positions of bird and pipes
    flappyBird = flappyBird.updatePosition(dt);
    managePipeArray();
    
    hold off     % clean the figure
    
    % draw bird and pipes
    flappyBird.shape.draw();
    hold on
    for pipe = pipeArray
        pipe.draw()
        hold on
    end
    
    % test for collisions and interrupt the loop if one is detected or if
    % the bird falls off the map
    if (pipeArray(1).x < THRESH && pipeArray(1).intersects(flappyBird.shape) == true) || flappyBird.shape.center(2) < 0
        STOP = 1;
    end
    
    % sets the plot variables and draws
    axis equal
    axis([0 ARENA_LENGTH+1 0 ARENA_HEIGHT])    % The following commands set up the display of the plot 
    drawnow
end

function buttonCallback(~, ~)  % updates vertical velocity when button is pressed
    global flappyBird;
    global CUTOFF_SPEED;
    global SPEED_INCREMENT;
    global STOP;
    if STOP == 2  % for starting the game
        STOP = 0;
    end
    if flappyBird.v(2) < CUTOFF_SPEED
        flappyBird = flappyBird.incrementVelocity(SPEED_INCREMENT);
    end
end

function stopButtonCallback(~, ~)  % interrupts the game and closes the plot window
    global STOP;  
    STOP = 1;
    close all;
end

function managePipeArray()
    global pipeArray;
    global GAP_WIDTH;
    global PIPE_TO_PIPE_DIST;
    global ARENA_LENGTH;
    global dt;
    
    for i = 1:length(pipeArray)  % updates pipe positoons
        pipeArray(i) = pipeArray(i).updatePosition(dt);
    end
    
    if pipeArray(1).x + GAP_WIDTH <= 0    % removes the first element if it exited the screen 
        pipeArray = pipeArray(2: length(pipeArray));
    end
    
    if pipeArray(length(pipeArray)).x + GAP_WIDTH + PIPE_TO_PIPE_DIST <= ARENA_LENGTH  % adds a new pipe to the screen
        pipeArray = [pipeArray, 'g'];
    end
end