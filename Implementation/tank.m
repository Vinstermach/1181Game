classdef tank
    properties
        length = 32;
        health = 5;
        dir = 'up'
        fire = 0;
        fireCD = 10; %time interval between each shot
        reload = 0;
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
        function checkOri(obj)
            %non-used function
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