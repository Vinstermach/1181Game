classdef background < handle
    properties
        scale;      % number of units 
        multiplier; % the pixel of each unit 
        length;
        path;
        value;
        barrierMatrix; %boolean matrix recording where are the blocks
    end
    
    methods
        function obj = background(Scale, Multiplier, Path) %init
            obj.scale = Scale;
            obj.multiplier = Multiplier;
            obj.length = obj.scale * obj.multiplier;
            obj.path = Path;
            obj.value = imread(obj.path);
        end

    end
        
end