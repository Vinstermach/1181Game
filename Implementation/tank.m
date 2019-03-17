classdef tank < handle
    properties
        length = 32;
        health = 5;
        dir;
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
            %initilizing 
            obj.x = X;
            obj.y = Y;
            obj.oriValue = flip(imread(Path) ,1);
            obj.value = obj.oriValue;
        end

        function obj = checkOri(obj)
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
        end
        
        function obj = checkBorder(obj, bg)
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
        
        function decision(obj, opponent, bg)
            %hard code this as ai algorithm 
            if (randi([0, 1])) %random move in x or y
                if (opponent.x > obj.x)
                    obj.x = obj.x + bg.multiplier;
                    obj.dir = "right";
                elseif (opponent.x < obj.x)
                    obj.x = obj.x - bg.multiplier;
                    obj.dir = "left";
                end  
            else
                if (opponent.y > obj.y)
                    obj.y = obj.y + bg.multiplier;
                    obj.dir = "up";
                elseif (opponent.y < obj.y)
                    obj.y = obj.y - bg.multiplier;
                    obj.dir = "down";
                end  
            end
        end
    end
        
end