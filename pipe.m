classdef pipe
    properties
        top;    % top half of the pipe
        bottom; % bottom half of the pipe
        x;      % x position of the pipe
        v;      % velocity
        color;  % color
    end
    
    methods
        function obj = pipe(color)
            global ARENA_LENGTH;
            global ARENA_HEIGHT;
            global GAP_HEIGHT;
            global GAP_WIDTH;   
            global HORIZONTAL_SPEED;
            global RANGE;
            gapCenter = 2 * RANGE * rand();    % chooses the center of the gap between pipes using a uniform distribution
            gapCenter = ARENA_HEIGHT/2 + (gapCenter - RANGE);
            
            % creates polygons for the top and bottom halves of the pipe
            topMat = [0 0 GAP_WIDTH GAP_WIDTH 0; 
                        0 gapCenter - GAP_HEIGHT/2 gapCenter - GAP_HEIGHT/2 0 0];
            bottomMat = [0, 0, GAP_WIDTH, GAP_WIDTH, 0; 
                ARENA_HEIGHT, gapCenter+GAP_HEIGHT/2, gapCenter+GAP_HEIGHT/2, ARENA_HEIGHT, ARENA_HEIGHT];
            
            % initializes the pipe at the rightmost side of the screen
            obj.top = shape(topMat, color);
            obj.top = obj.top.translateShape([ARENA_LENGTH; 0]);
            obj.bottom = shape(bottomMat, color);
            obj.bottom = obj.bottom.translateShape([ARENA_LENGTH; 0]);
            obj.x = ARENA_LENGTH;
            obj.v = [-HORIZONTAL_SPEED; 0];
            obj.color = color;
        end
        
        function obj = updatePosition(obj, dt)
            % increment positions using time step
           obj.top =  obj.top.translateShape(obj.v*dt);
           obj.bottom =  obj.bottom.translateShape(obj.v*dt);
           obj.x = obj.x + obj.v(1) * dt;
        end
        
        function draw(obj)  % draws top and bottom of pipe
            obj.top.draw();
            hold on
            obj.bottom.draw();
        end
        
        function b = intersects(obj, s)  % checks if a shape intersects with either part of the pipe
            bl = false;
            for i = 1:length(s.mat)
                p = [s.mat(1, i); s.mat(2, i)];
                
                if obj.top.contains(p) || obj.bottom.contains(p)
                    bl = true;
                end
            end
            b = bl;
        end
    end
    
end