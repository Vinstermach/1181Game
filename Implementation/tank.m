classdef tank
    properties
        length = 32;
        health = 5;
        dir = 'up'
        oriValue;
        value;
        x;
        y;
    end
    
    methods
        function obj = tank(X, Y, Path)
            obj.x = X;
            obj.y = Y;
            obj.oriValue = flip(imread(Path) ,1);
            obj.value = obj.oriValue;
        end
    end
    methods (Static)
        function check(obj)
            if (obj.dir == "up") 
                obj.value = obj.oriValue; end
            if (obj.dir == "down") 
                obj.value = imrotate(obj.oriValue, 180,'bilinear'); end
            if (obj.dir == "left") 
                obj.value = imrotate(obj.oriValue, -90,'bilinear'); end
            if (obj.dir == "up") 
                obj.value = imrotate(obj.oriValue, 90,'bilinear'); end
        end
    end
        
end