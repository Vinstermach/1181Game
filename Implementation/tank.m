classdef tank < handle
    properties
        length = 32;
        health = 5;
        dir;
        fire = 0;
        fireCD = 10; %time interval between each shot
        countDown = 0;
        oriValue;
        value;
        inMapX;
        inMapY;
        x;
        y;
    end
    
    methods
        function obj = tank(X, Y, Path)
            %initilizing 
            obj.x = X;
            obj.y = Y;
            obj.oriValue = flip(imread(Path) ,1);
            obj.value = obj.oriValue;
        end
        
        function obj = checkStatus(obj, bg)
            
            %translate grid coordinates to plotting coordinates
            obj.inMapX = obj.x * bg.multiplier;
            obj.inMapY = obj.y * bg.multiplier;
            
            obj.countDown = obj.countDown - 1;
            if (obj.countDown < 0) 
                obj.countDown = 0; end

            %make the tank turn towards its direction 
            if (obj.dir == "up") 
                obj.value = obj.oriValue;
            elseif (obj.dir == "down") 
                obj.value = imrotate(obj.oriValue, 180,'bilinear');
            elseif (obj.dir == "left") 
                obj.value = imrotate(obj.oriValue, -90,'bilinear');
            elseif (obj.dir == "right") 
                obj.value = imrotate(obj.oriValue, 90,'bilinear');
            end
            
            %check if the tank is within game border
            borderLoc = bg.length/2;
            if (obj.x > borderLoc - bg.multiplier)
                obj.x = borderLoc - bg.multiplier;
            elseif (obj.x < -borderLoc)
                obj.x = -borderLoc;
            end
            
            if (obj.y > borderLoc - bg.multiplier)
                obj.y = borderLoc - bg.multiplier;
            elseif (obj.y < -borderLoc)
                obj.y = - borderLoc;
            end
        end
        
        function decision(obj, opponent)
            %hard code this as AI algorithm 
            if (randi([0, 1])) %random move in x or y
                if (opponent.x > obj.x)
                    obj.x = obj.x + 1;
                    obj.dir = "right";
                elseif (opponent.x < obj.x)
                    obj.x = obj.x - 1;
                    obj.dir = "left";
                end  
            else
                if (opponent.y > obj.y)
                    obj.y = obj.y + 1;
                    obj.dir = "up";
                elseif (opponent.y < obj.y)
                    obj.y = obj.y - 1;
                    obj.dir = "down";
                end  
            end
        end
    end
        
end