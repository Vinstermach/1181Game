classdef tank
    properties
        length = 32;
        health = 5;
        dir = 'down'
        value;
        x;
        y;
    end
    
    methods
        function obj = tank(X, Y, Path)
            obj.x = X;
            obj.y = Y;
            obj.value = imread(Path);
        end
        
        %function obj = display()
            
        %end
    end
        
end