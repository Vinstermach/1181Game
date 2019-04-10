

score = [9, 9, 5, 5, 4, 4, 5, 0, 6, 6, 7, 7, 8, 8, 9, 0,  ...
    5, 5, 6, 6, 7, 7, 8, 0, 5, 5, 6, 6, 7, 7, 8, 0, ...
    9, 9, 6, 6, 5, 5, 6, 0, 7, 7, 8, 8, 9, 9, 10];
aryRd();

function aryRd()
    ary = ["resources\musics\nyan.mp3", "resources\musics\red.mp3",...
        "resources\musics\tequila.mp3"];
    test = audioread(ary(1));
    muse = audioplayer(test, 44100);
    play(muse);

end
function timer()
    [y,Fs] = audioread('resources\test.mp3'); % y samples from audio with Fs sampling frequency in [Hz].
    sound(y,Fs);% listen your audio input
    N = length(y); % sample lenth
    slength = N/Fs; % total time span of audio signal
    disp(slength);
    disp(N);

end
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

