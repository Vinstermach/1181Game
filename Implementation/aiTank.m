classdef aiTank < tank
    
    methods
        function xLoc = getOppoX(opponent)
            % get opponent x loction
            xLoc = opponent.x;
        end
        function yLoc = getOppoY(opponent)
            % get opponent y location 
            yLoc = opponent.y;
        end
        
        function decision(obj, opponent, map)
            if (randi([0, 1]))
                if (opponent.x > obj.x)
                    obj.x = obj.x + 1;
                elseif (opponent.x < obj.x)
                    obj.x = obj.x - 1;
                end  
            else
                if (opponent.y > obj.y)
                    obj.y = obj.y + 1;
                elseif (opponent.y < obj.y)
                    obj.y = obj.y - 1;
                end  
            end
        end
    end
end