classdef bird
    properties
        shape;  % shape of bird
        v;      % velocity on the ground referential
    end
    
    methods
        function obj = bird(shape, color)  % constructor
            global HORIZONTAL_SPEED;
            obj.shape = shape;
            obj.shape.color = color;
            obj.v = [HORIZONTAL_SPEED; 0];
        end
        
        function obj = incrementVelocity(obj, vel)  % sets vertical velocity to vel
            global HORIZONTAL_SPEED;
            obj.v = [HORIZONTAL_SPEED; vel];
            obj.shape = obj.shape.alignToVec(obj.v);
        end
        
        function draw(obj)  % draws the bird's shape
            obj.shape.draw();
        end
        
        function obj = updatePosition(obj, dt)  % increments position based on velocity
            obj.shape = obj.shape.translateShape(obj.v*dt .* [0;1]);
        end
        
    end
    
end