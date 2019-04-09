classdef tank < handle
    properties
        length = 32; % the pixel length of the tank image
        oriValue;    % records the original image
        value;       % image used in the plot
        upValue;     % image of tank facing up
        downValue;   % image of tank facing down
        leftValue;   % image of tank facing keft
        rightValue;  % image of tank facing right
        bg;          % background, or to say the environment
        opponent;    % reference opponent more easily 
        
        lifes;       % just... lifes
        HPpool = 3;  % max hit could afford
        health;      % current health
        dir;         % facing direction
        
        fire = 0;    % whether player press the key to fire
        fireCD = 6;  % time interval between each shot
        countDown = 0;   % CD from last attack
        shells;  % alias of `bullets`
        
        birthX;      % relative coordintes of tanks' birth place
        birthY;      
        inMapX;      % absolute coordintes in the plot
        inMapY;
        x;           % relative coordintes in the plot
        y;
    end
    
    methods
        function obj = tank(X, Y, Path, BG)
            %initilizing 
            obj.birthX = X;
            obj.birthY = Y;
            obj.x = X;
            obj.y = Y;
            obj.health = obj.HPpool;
            obj.lifes = 3;
            obj.oriValue = flip(imread(Path) ,1);
            obj.upValue = obj.oriValue;
            obj.downValue = imrotate(obj.oriValue, 180,'bilinear');
            obj.leftValue = imrotate(obj.oriValue, -90,'bilinear');
            obj.rightValue = imrotate(obj.oriValue, 90,'bilinear');
            obj.bg = BG;
            obj.shells = bullets(8);
            obj.shells.bg = BG;
        end
        %==================================================================
        function obj = checkStatus(obj)
            
            % count down time before next shot
            obj.countDown = obj.countDown - 1;
            if (obj.countDown < 0) 
                obj.countDown = 0; end

            % make the tank turn towards its direction 
            if (obj.dir == "up") 
                obj.value = obj.upValue;
            elseif (obj.dir == "down") 
                obj.value = obj.downValue;
            elseif (obj.dir == "left") 
                obj.value = obj.leftValue;
            elseif (obj.dir == "right") 
                obj.value = obj.rightValue;
            end
            
            % translate grid coordinates to plotting coordinates
            obj.inMapX = obj.x * obj.bg.multiplier;
            obj.inMapY = obj.y * obj.bg.multiplier;
            
            % gonna add hitting algorithm in this function
            obj.shells.updateBullets();
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
        function res = opponentAhead(obj, direction)
            % this fucntion is created to avoid player position colliding 
            res = false;     % by default its not collide
            switch direction
            case "left" 
                % if player is moving towards left 
                % and opponent is at the left side, then return false
                if (obj.opponent.x == obj.x-1 && obj.opponent.y == obj.y)
                    res = true;
                end
            case "right"
                if (obj.opponent.x == obj.x+1 && obj.opponent.y == obj.y)
                    res = true;
                end
            case "up"
                if (obj.opponent.x == obj.x && obj.opponent.y == obj.y+1)
                    res = true;
                end
            case "down"
                if (obj.opponent.x == obj.x && obj.opponent.y == obj.y-1)
                    res = true;
                end
            end
        end
        %==================================================================
        function obj = move(obj, direction)
            % `direction` is the direction tank intend to move
            switch direction
                case "left"
                    if (obj.bg.barriers(obj.y+1, obj.x) ~= 1) &&...
                            (~obj.opponentAhead(direction)) 
                        % if that direction has no wall
                        % and opponent is not at that direction, then move
                        obj.x = obj.x - 1;
                        obj.dir = direction;
                    end
                case "right"
                    if (obj.bg.barriers(obj.y+1, obj.x+2) ~= 1) &&...
                            (~obj.opponentAhead(direction)) 
                        obj.x = obj.x + 1;
                        obj.dir = direction;
                    end
                case "up"
                    if (obj.bg.barriers(obj.y+2, obj.x+1) ~= 1) &&...
                            (~obj.opponentAhead(direction)) 
                        obj.y = obj.y + 1;
                        obj.dir = direction;
                    end
                case "down"
                    if (obj.bg.barriers(obj.y, obj.x+1) ~= 1) &&...
                            (~obj.opponentAhead(direction))   
                        obj.y = obj.y - 1;
                        obj.dir = direction;
                    end
            end
        end
        %==================================================================
        function obj = decision(obj)
            % hard code this as AI algorithm 
            if (randi([0, 1])) %random move in x or y
                if (obj.opponent.x > obj.x)
                    obj.move("right");
                elseif (obj.opponent.x < obj.x)
                    obj.move("left");
                end
            else
                if (obj.opponent.y > obj.y)
                    obj.move("up");
                elseif (obj.opponent.y < obj.y)
                    obj.move("down");
                end  
            end
            
            % shoot if the player is ahead
            if (obj.x == obj.opponent.x)
                if (obj.y < obj.opponent.y && obj.dir == "up")
                    obj.fireAttempt();
                elseif (obj.y > obj.opponent.y && obj.dir == "down")
                    obj.fireAttempt();
                end
            end
            if (obj.y == obj.opponent.y)
                if (obj.x > obj.opponent.x && obj.dir == "left")
                    obj.fireAttempt();
                elseif (obj.x < obj.opponent.x && obj.dir == "right")
                    obj.fireAttempt();
                end
            end
            
        end
        %==================================================================
        function obj = decisionAdvanced(obj)
            moveUpWeight = 0;
            moveDownWeight = 0;
            moveLeftWeight = 0;
            moveRightWeight = 0;
            
            if (obj.opponent.x > obj.x)
                moveRightWeight = moveRightWeight + obj.opponent.x - obj.x;
            elseif (obj.opponent.x < obj.x)
                moveLeftWeight = moveLeftWeight + obj.x - obj.opponent.x ;
            elseif (obj.opponent.y > obj.y)
                moveUpWeight = moveUpWeight + obj.opponent.y - obj.y;
            elseif (obj.opponent.y < obj.y)
                moveDownWeight = moveDownWeight + obj.y - obj.opponent.y;
            end  
            
            % plus random weight
            moveUpWeight = moveUpWeight + rand();
            moveDownWeight = moveDownWeight + rand();
            moveLeftWeight = moveLeftWeight + rand();
            moveRightWeight = moveRightWeight + rand();
            
            % mask unaviliabe path
            moveUpWeight = moveUpWeight * ~obj.bg.barriers(obj.y+2, obj.x+1);
            moveDownWeight = moveDownWeight * ~obj.bg.barriers(obj.y, obj.x+1);
            moveLeftWeight = moveLeftWeight * ~obj.bg.barriers(obj.y+1, obj.x);
            moveRightWeight = moveRightWeight * ~obj.bg.barriers(obj.y+1, obj.x+2);
            
            tempAry = [moveUpWeight; moveDownWeight; moveLeftWeight; moveRightWeight];
            [elem, indx] = max(tempAry);
            switch indx
                case 1
                    obj.move("up");
                case 2
                    obj.move("down");
                case 3
                    obj.move("left");
                case 4
                    obj.move("right");
            end
            
            % shoot if the player is ahead
            if (obj.x == obj.opponent.x)
                if (obj.y < obj.opponent.y && obj.dir == "up")
                    obj.fireAttempt();
                elseif (obj.y > obj.opponent.y && obj.dir == "down")
                    obj.fireAttempt();
                end
            end
            if (obj.y == obj.opponent.y)
                if (obj.x > obj.opponent.x && obj.dir == "left")
                    obj.fireAttempt();
                elseif (obj.x < obj.opponent.x && obj.dir == "right")
                    obj.fireAttempt();
                end
            end
            
        end
    end
        
end