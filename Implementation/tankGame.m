
%% main goes here
main();

function main()
    global game;
    global bg; global p1; global p2;
    bg = background(16, 32);
    p1 = tank();
    p2 = tank(); 
    
    init(); % initlizing
    
    while(game.on)
        exmRange();
        p1.display(game.mainScreen);
        p2.display(game.mainScreen);
        drawnow % update plot
    end
    
    close(1) % close the figure, otherwise it'll remain in memeory 
end

function init()
    global game;
    global bg; global p1; global p2;
    game.UI = figure('menubar','none',...
               'numbertitle','off');
    hold on;
    axis([-bg.length/2, bg.length/2, -bg.length/2, bg.length/2])
    
    bornLocX = randi(bg.length/2); %random interger
    bornLocY = randi(bg.length/2); 
    p1.x = bornLocX; p1.y = bornLocY;
    p2.x = -bornLocX; p2.y = -bornLocY;
    
    set(gcf,'WindowKeyPressFcn',@pressKey);
    set(gca,'xtick',[]); set(gca,'xticklabel',[]);
    set(gca,'ytick',[]); set(gca,'yticklabel',[]);
    drawnow
end

function pressKey(~, ed)
    global game;
    global bg; global p1; global p2;
    switch ed.Key
        case 'q'
            game.gameOn = 0;
        % player one
        case 'leftarrow' 
            p1.x = p1.x - 1;
            p1.dir = 'left';
        case 'rightarrow'  
            p1.x = p1.x + 1;
            p1.dir = 'right';
        case 'uparrow' 
            p1.y = p1.y + 1;
            p1.dir = 'up';
        case 'downarrow' 
            p1.y = p1.y - 1;
            p1.dir = 'down';
        % player two
        case 'a' 
            p2.x = p2.x - 1;
            p2.dir = 'left';
        case 'd'  
            p2.x = p2.x + 1;
            p2.dir = 'right';
        case 'w' 
            p2.y = p2.y + 1;
            p2.dir = 'up';
        case 's' 
            p2.y = p2.y - 1;
            p2.dir = 'down';
    end
end

function exmRange()
    % see if the location of 2 players are inside the map
    global game;
    global bg; global p1; global p2;
    
    if (p1.x > bg.length/2)
        p1.x = bg.length/2;
    else if (p1.x < -bg.length/2)
        p1.x = -bg.length/2;
        end
    end
    if (p1.y > bg.length/2)
        p1.y = bg.length/2;
    else if (p1.y < -bg.length/2)
        p1.y = -bg.length/2;
        end
    end
    
    if (p2.x > bg.length/2)
        p2.x = bg.length/2;
    else if (p2.x < -bg.length/2)
        p2.x = -bg.length/2;
        end
    end
    if (p2.y > bg.length/2)
        p2.y = bg.length/2;
    else if (p2.y < -bg.length/2)
        p2.y = -bg.length/2;
        end
    end
end
