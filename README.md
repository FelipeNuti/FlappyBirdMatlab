# Flappy Bird clone on MATLAB
- Made by [Felipe Nuti](https://www.linkedin.com/in/felipe-nuti/) at St. John's College, Oxford.
## Introduction
This project was done as an assignment for the 2nd session of the Computing Lab of the 1st year Engineering course at the University of Oxford. Its objective was to exercise the creative use of MATLAB functions (mainly related to animation) and to practice programming.

I took this as an opportunity to also practice object-oriented programming, with which I came into contact when programming in C++ and Java. In particular, I practiced this programming paradigm when doing Princeton's [Algorithms courses](https://www.coursera.org/learn/algorithms-part1) on Coursera earlier during Christmas Break. I chose this design pattern because problems that are naturally described as an interaction of entities (birds, pipes, etc.) are particularly well-suited for an OOP approach (and it would have been cumbersome to do it any other way). 

## How to play
* Run the script `FlappyBird.m`;
* A window with a polygon (resembling a bird) will open. Hit the **FLY!** button on the lower left corner to start the game;
* The game works largely like the hit mobile app from 2013. Press the **FLY!** button to boost the bird up and avoid hitting the pipes;
* If you hit a pipe, you lose the game;
* Press the **QUIT** button to close the window and terminate the program.

## How the project is organized
The basic object type for both the bird and the pipes is `shape`. It contains, among other attributes:
* a matrix that describes the polygon of the shape;
* a vector that describes the orientation of the shape relative to the matrix given on the constructor (this is used for aligning the bird with its velocity);
* the color of the shape;

It is through `shape` that the positions and orientations are manipulated. This includes translations, rotations and collision detection. It is here that the functions from the Computing Lab exercises are called. This made the project much more organized than it would have been without OOP.

The `bird` object is nothing more than a shape with a velocity. A `pipe` contains an upper and a lower shape. It is in between these shapes that the bird must pass.

The main program `FlappyBird.m` firstly defines "environment variables" as global variables for use in the main loop and other functions. Such variables include gravitational acceleation, dimensions of the screen, and others. An instance of `bird` is created along with a queue of pipes (not implemented as a separate class for simplicity). 

On the main loop, the bird's velocity is decremented until it reaches a cutoff velocity, after which it stay constant until the user gives the **FLY!** command. When this command is given, the bird's velocity is set to a velocity `SPEED_INCREMENT`. Meanwhile, the pipes move left at a constant speed.

The loop checks for a collision between the bird and the leftmost pipe, and exits if one is detected. Then, the user must press the **QUIT** button to close the game.