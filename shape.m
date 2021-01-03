classdef shape
    %Shape geometric shape
    %   Contains a matrix of points and a direction vector to denote its
    %   orientation
    
    properties
        mat;          % matrix defining the polygon of the shape
        vec;          % unit vector defining the direction of the shape 
        boundingRect; % matrix representing the smallest rectangle "parallel" to the coordinate axis that contains the shape
        center;       % center of the bounding rectangle
        color;        % color of the shape
    end
    
    methods
        function obj = shape(mat, color)  % constructor            
            obj.mat = mat;
            obj.vec = [1; 0];
            obj = updateBoundingRect(obj);
            obj = findCenter(obj); 
            obj.color = color;
        end
        
        function obj = updateBoundingRect(obj)  % finds the maximum and minimum x and y coordinates of the shape to define the bounding rect
            maxX = max(obj.mat(1, :));
            minX = min(obj.mat(1, :));
            maxY = max(obj.mat(2, :));
            minY = min(obj.mat(2, :));
            obj.boundingRect = [maxX maxX minX minX;
                                maxY minY maxY minY];
        end
        
        function obj = findCenter(obj)   % finds the center of the bounding rect
            maxX = max(obj.mat(1, :));
            minX = min(obj.mat(1, :));
            maxY = max(obj.mat(2, :));
            minY = min(obj.mat(2, :));
            obj.center = [(maxX+minX)/2;
                            (maxY+minY)/2];
        end
                            
        function obj = alignToVec(obj, vec)    % rotates the shape such that it is aligned to a vector "vec"
            angle = asin((obj.vec(1)*vec(2) - obj.vec(2)*vec(1))/((obj.vec' * obj.vec) * (vec' * vec)));
            obj.mat = rotateabout(obj.mat, angle, obj.center(1), obj.center(2));
            obj.boundingRect = rotateabout(obj.boundingRect, angle, obj.center(1), obj.center(2));
            obj.vec = rotateabout(obj.vec, angle, 0, 0);
        end
        
        function bool = contains(obj, point)  % checks if a point is contained in the shape
            maxX = obj.boundingRect(1,1);
            minX = obj.boundingRect(1,3);
            maxY = obj.boundingRect(2,1);
            minY = obj.boundingRect(2,2);
            
            if point(1) <= maxX  && point(1) >= minX && point(2) <= maxY && point(2) >= minY
                bool = true;
            else
                bool = false;
            end
        end
        
        function obj = translateShape(obj, dr)  % translates shape
            obj.mat = translate(obj.mat, dr(1), dr(2));
            obj.boundingRect = translate(obj.boundingRect, dr(1), dr(2));
            obj.center = translate(obj.center, dr(1), dr(2));
        end
        
        function draw(obj)    % draws shape as a filled polygon
            filledshape(obj.mat, obj.color);
        end
        
    end
end

