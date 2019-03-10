classdef background
    properties
        scale;      % number of units 
        multiplier; % the pixel of eaxh unit 
        length;
        path;
    end
    
    methods
        function obj = background(Scale, Multiplier, Path) %init
            obj.scale = Scale;
            obj.multiplier = Multiplier;
            obj.length = scale * multiplier;
            obj.path = Path;
            
        end
    end
        
end