

score = [9, 9, 5, 5, 4, 4, 5, 0, 6, 6, 7, 7, 8, 8, 9, 0,  ...
    5, 5, 6, 6, 7, 7, 8, 0, 5, 5, 6, 6, 7, 7, 8, 0, ...
    9, 9, 6, 6, 5, 5, 6, 0, 7, 7, 8, 8, 9, 9, 10];
music(score);

function music(score)
    timeDur = 0.4;
    score = score * 1000;
    for fs = score
        if fs == 0
           pause(timeDur*0.8); 
        end
        amp = 10; 
        duration=timeDur;
        freq=500;
        values=0:1/fs:duration;
        a=amp*sin(2*pi*freq*values);
        sound(a);
        pause(timeDur)
    end
end

