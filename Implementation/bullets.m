classdef bullets < handle
    %still working 
    properties
        range; %effective range of bullet
        x;
        y;
    end
    
    methods
        function obj = bullets(effectiveRange)
            %initilizing
            obj.range = effectiveRange;
        end
        
        function obj = addBullet(obj, direction, startX, startY)
        end
        
        function obj = updateBullets(obj)
        end
    end
end