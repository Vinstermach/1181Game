%% main goes here
main();

function main()
    global game;
    global bg; global p1; global p2;
    bg = background(25, 32, 'resources\basebackground.png'); %unmber of units, pixel per unit
    p1 = tank(bg.length/2, bg.length/2, 'resources\tank1.png');
    p2 = tank(-bg.length/2, -bg.length/2, 'resources\tank2.png'); 
    
    init(); % initlizing
    
    while(game.on)
        exmStatus();
        delete(get(gca,'Children'))
        imagesc(-bg.length/2, -bg.length/2, bg.value);
        imagesc(p1.x, p1.y, p1.value);
        imagesc(p2.x, p2.y, p2.value);
        drawnow; % update plot
    end
    
    close(1);
end

function init()
    global game;
    game.on = true;
    global bg; global p1; global p2;
    game.UI = figure('menubar','none',...
               'numbertitle','off');
           
    hold on;
    axis([-bg.length/2, bg.length/2, -bg.length/2, bg.length/2])
    game.mainScreen = plot([-bg.length/2, bg.length/2], [-bg.length/2, bg.length/2]);
    
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
            game.on = 0;
        % player one
        case 'leftarrow' 
            p1.x = p1.x - bg.multiplier;
            p1.dir = "left";
        case 'rightarrow'  
            p1.x = p1.x + bg.multiplier;
            p1.dir = "right";
        case 'uparrow' 
            p1.y = p1.y + bg.multiplier;
            p1.dir = "up";
        case 'downarrow' 
            p1.y = p1.y - bg.multiplier;
            p1.dir = "down";
        case '?'
            p1.fire = 1;
        
        % player two
        case 'a' 
            p2.x = p2.x - bg.multiplier;
            p2.dir = "left";
        case 'd'  
            p2.x = p2.x + bg.multiplier;
            p2.dir = "right";
        case 'w' 
            p2.y = p2.y + bg.multiplier;
            p2.dir = "up";
        case 's' 
            p2.y = p2.y - bg.multiplier;
            p2.dir = "down";
        case 'e' 
            p2.fire = 1;
    end
end

function exmStatus()
    % see if the location of 2 players are inside the map
    global game;
    global bg; global p1; global p2;
    
    borderLoc = bg.length/2;
    if (p1.x > borderLoc - bg.multiplier)
        p1.x = borderLoc - bg.multiplier;
    else if (p1.x < -borderLoc)
        p1.x = -borderLoc;
        end
    end
    if (p1.y > borderLoc - bg.multiplier)
        p1.y = borderLoc - bg.multiplier;
    else if (p1.y < -borderLoc)
        p1.y = - borderLoc;
        end
    end
    
    if (p2.x > bg.length/2 - bg.multiplier)
        p2.x = bg.length/2 - bg.multiplier;
    else if (p2.x < -bg.length/2)
        p2.x = -bg.length/2;
        end
    end
    if (p2.y > bg.length/2 - bg.multiplier)
        p2.y = bg.length/2 - bg.multiplier;
    else if (p2.y < -bg.length/2)
        p2.y = -bg.length/2;
        end
    end
    
    if (p1.dir == "up") 
        p1.value = p1.oriValue; end
    if (p1.dir == "down") 
        p1.value = imrotate(p1.oriValue, 180,'bilinear'); end
    if (p1.dir == "left") 
        p1.value = imrotate(p1.oriValue, -90,'bilinear'); end
    if (p1.dir == "right") 
        p1.value = imrotate(p1.oriValue, 90,'bilinear'); end
    
    if (p2.dir == "up") 
        p2.value = p2.oriValue; end
    if (p2.dir == "down") 
        p2.value = imrotate(p2.oriValue, 180,'bilinear'); end
    if (p2.dir == "left") 
        p2.value = imrotate(p2.oriValue, -90,'bilinear'); end
    if (p2.dir == "right") 
        p2.value = imrotate(p2.oriValue, 90,'bilinear'); end

end