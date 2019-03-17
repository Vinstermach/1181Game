classdef bullet < handle
    %still working 
    
    % this class is only used in class bullets
    
    % the difference between `bullets` and `bullet`
    % is that `bullet` is one single bullet
    % and `bullets` are the collection of all bullects in game screen
    
    properties
        direction;
        traveled = 0;
        startX;
        startY;
        x; % current x coordinate
        y; % current x coordinate
    end
    
    methods
        function obj = bullet(Direction, StartX, StartY)
            %initilizing
            obj.direction = Direction;
            obj.startX = StartX; % stay constant
            obj.startY = StartY; % stay constant
            obj.x = StartX;
            obj.y = StartY;
        end
        
    end
    
end