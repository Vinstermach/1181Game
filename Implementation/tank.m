classdef tank
    properties
        length = 32;
        health = 5;
        dir = 'up'
        x;
        y;
    end
    
    methods
        function obj = tank(X, Y)
            obj.x = X;
            obj.y = Y;
        end
        
        function obj = display()
            
        end
    end
        
end