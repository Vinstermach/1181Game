classdef music < handle
    properties
        whoa = 0;
        amp = 10;
        duration = 0.2;
        
    end
    
    methods
        function obj = music()
           obj.whoa = 0; 
        end
        
        function obj = tone(obj, note, freq)        
            fs = note * 2000; %20500
            values = 0 : 1/fs : obj.duration;
            a = obj.amp * sin(2 * pi * freq * values);
            sound(a);
        end
    end
    
    
end