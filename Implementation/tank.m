classdef tank < handle
    properties
        length = 32; % the pixel length of the tank image
        oriValue;    % records the original image
        value;       % modified `oriValue`, used to display the image
        bg;          % background, or to say the environment
        
        health = 5;  % max hit could afford
        dir;    % facing direction
        
        range = 12;  % effective range of bullet
        fire = 0;    % whether player press the key to fire
        fireCD = 6;  % time interval between each shot
        countDown = 0;   % CD from last attack
        shells = bullets(10);  % alias of `bullets`
        
        inMapX;      % absolute coordintes in the plot
        inMapY;
        x;           % relative coordintes in the plot
        y;
        histX;       % history coordinate, used to restore location
        histY;
    end
    
    methods
        function obj = tank(X, Y, Path, BG)
            %initilizing 
            obj.x = X;
            obj.y = Y;
            obj.oriValue = flip(imread(Path) ,1);
            obj.value = obj.oriValue;
            obj.bg = BG;
            obj.shells.bg = BG;
        end
        %==================================================================
        function obj = checkStatus(obj, opponent)
            
            % count down to next shot
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
            borderLoc = obj.bg.scale;
            if (obj.x > borderLoc - 1)
                obj.x = borderLoc - 1;
            elseif (obj.x < 0)
                obj.x = 0;
            end
            if (obj.y > borderLoc - 1)
                obj.y = borderLoc - 1;
            elseif (obj.y < 0)
                obj.y = 0;
            end
            
            if (obj.bg.barriers(obj.y+1, obj.x+1) == 1)
                obj.x = obj.histX;
                obj.y = obj.histY;
            end
            %translate grid coordinates to plotting coordinates
            obj.inMapX = obj.x * obj.bg.multiplier;
            obj.inMapY = obj.y * obj.bg.multiplier;
            
            obj.shells.updateBullets(opponent);
        end
        %==================================================================
        function obj = fireAttempt(obj)
            % try to shot
            if (obj.countDown == 0)
                obj.countDown = obj.fireCD; % reset cooldown
                newBullet = bullet(obj.dir, obj.x, obj.y);
                obj.shells.listOfBul = [obj.shells.listOfBul, newBullet];
            end
        end
        %==================================================================
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