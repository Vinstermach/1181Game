classdef bullets < handle
    %still working 
    properties
        bg;    % background, or to say the environment
        listOfBul;  % list of bullets
        range; % effective range of bullet
        Xs;    % absolute coordintes in the plot
        Ys;
        dia = 7;   % size of the bullet, only used in `scatter()`
        color = 'w';     % color of the bullets
    end
    
    methods
        function obj = bullets(effectiveRange)
            %initilizing
            obj.range = effectiveRange;
            obj.listOfBul = [];
        end
        %==================================================================
        function obj = addBullet(obj, direction, startX, startY)
            newBullet = bullet(direction, startX, startY);
            obj.listOfBul = [obj.listOfBul, newBullet];
            obj.Xs = [obj.Xs, newBullet.x * obj.bg.multiplier];
        end
        %==================================================================
        function obj = updateBullets(obj)
            obj.Xs = []; obj.Ys = []; % clear coordinates
            outdates = [];  % index of bullets out of date or hit the target

            % `for` makes the bullets move an extra step in each `while`loop
            % thus tank can never cathc the bullet
            for i = 1 : length(obj.listOfBul)
                % count distance
                obj.listOfBul(i).traveled = obj.listOfBul(i).traveled + 1;
                
                
                if (obj.listOfBul(i).direction == "up") && (obj.listOfBul(i).y <= 14) &&...
                        (obj.bg.barriers(obj.listOfBul(i).y+2, obj.listOfBul(i).x+1) ~= 1)
                        obj.listOfBul(i).y = obj.listOfBul(i).y + 1;
                elseif (obj.listOfBul(i).direction == "down") && (obj.listOfBul(i).y >= 3) &&...
                        (obj.bg.barriers(obj.listOfBul(i).y, obj.listOfBul(i).x+1) ~= 1)
                    obj.listOfBul(i).y = obj.listOfBul(i).y - 1;
                elseif (obj.listOfBul(i).direction == "left") && (obj.listOfBul(i).x >= 3) &&...
                        (obj.bg.barriers(obj.listOfBul(i).y+1, obj.listOfBul(i).x) ~= 1)
                    obj.listOfBul(i).x = obj.listOfBul(i).x - 1;
                elseif (obj.listOfBul(i).direction == "right") && (obj.listOfBul(i).x <= 14) &&...
                        (obj.bg.barriers(obj.listOfBul(i).y+1, obj.listOfBul(i).x+2) ~= 1)
                    obj.listOfBul(i).x = obj.listOfBul(i).x + 1;
                else
                    outdates = [outdates, i];
                end
                
                if (obj.listOfBul(i).direction == "up") && (obj.listOfBul(i).y <= 14) &&...
                        (obj.bg.barriers(obj.listOfBul(i).y+2, obj.listOfBul(i).x+1) ~= 1)
                        obj.listOfBul(i).y = obj.listOfBul(i).y + 1;
                elseif (obj.listOfBul(i).direction == "down") && (obj.listOfBul(i).y >= 3) &&...
                        (obj.bg.barriers(obj.listOfBul(i).y, obj.listOfBul(i).x+1) ~= 1)
                    obj.listOfBul(i).y = obj.listOfBul(i).y - 1;
                elseif (obj.listOfBul(i).direction == "left") && (obj.listOfBul(i).x >= 3) &&...
                        (obj.bg.barriers(obj.listOfBul(i).y+1, obj.listOfBul(i).x) ~= 1)
                    obj.listOfBul(i).x = obj.listOfBul(i).x - 1;
                elseif (obj.listOfBul(i).direction == "right") && (obj.listOfBul(i).x <= 14) &&...
                        (obj.bg.barriers(obj.listOfBul(i).y+1, obj.listOfBul(i).x+2) ~= 1)
                    obj.listOfBul(i).x = obj.listOfBul(i).x + 1;
                else
                    outdates = [outdates, i];
                end
                
                
                % calculate absloute coordinates of bullets in the plot
                offset = obj.bg.multiplier / 2;
                obj.Xs = [obj.Xs, obj.listOfBul(i).x * obj.bg.multiplier + offset];
                obj.Ys = [obj.Ys, obj.listOfBul(i).y * obj.bg.multiplier + offset];
            end
            
            obj.listOfBul(outdates) = []; % delete bullets
        end
        
    end
end
