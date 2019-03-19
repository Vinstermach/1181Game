classdef background < handle
    properties
        scale;       % number of units 
        multiplier;  % the pixel of each unit 
        length;
        grassPath;
        grassImg;
        value;       % the final image
        grassMatrix; % boolean matrix recording where are the blocks
        barriers;
    end
    
    methods
        function obj = background(Scale, Multiplier) %init
            obj.scale = Scale;
            obj.multiplier = Multiplier;
            obj.length = obj.scale * obj.multiplier;
            obj.grassPath = 'resources\Grass.png';
            obj.grassImg = imread(obj.grassPath);
            obj.readArray();
            obj.generateImage();
        end
        %=================================================================
        function obj = generateImage(obj)
            img = uint8(zeros(obj.length, obj.length, 3));
            rowStart = 1;
            for (row = 1 : obj.scale)
                rowEnd = rowStart + obj.multiplier - 1;
                colStart = 1;
                for (col = 1 : obj.scale)
                    colEnd = colStart + obj.multiplier - 1;
                    if(obj.grassMatrix(row, col) == 1)
                        img(rowStart : rowEnd, colStart : colEnd, :) = obj.grassImg;
                    end
                    colStart = colEnd + 1;
                end
                rowStart = rowEnd + 1;
            end
            obj.value = img;
            
            obj.barriers = obj.grassMatrix;
        end
        %=================================================================
        function obj = readArray(obj)
            % just initilize the array parameters
            % I don't want to put that on top, so moved into a function
            obj.grassMatrix = [...
                [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];...
                [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];...
                ];
            
            
        end
    end
        
end