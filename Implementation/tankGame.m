%% main goes here

%loadingScreen()
main();

function main()
    % coordinates of tanks are the scale version in the plot
    % absolute coordinates are denoted by `inMapX` and `inMapY`

    global game;
    game.botMatch = 0; % whether it's pve or pvp
    global bg; global p1; global p2;
    % p1 and p2 are human control, p3 is bot
    bg = background(16, 32, 'resources\basebackgroundAlt.png'); %unmber of units, pixel per unit
    p1 = tank(bg.scale/2 - 2, bg.scale/2 - 2, 'resources\tank1.png', bg);
    p2 = tank(-bg.scale/2 + 1, -bg.scale/2 + 1, 'resources\tank2.png', bg);
    p1.dir = "up"; p2.dir = "up";
    
    init(); % initlizing parameters
    
    while(game.on)
        delete(get(gca,'Children')); %clear plot
        
        if game.botMatch
            p2.decision(p1); end
        
        if  (p1.fire == 1) 
            p1.fireAttempt(); p1.fire = 0; end
        if  (p2.fire == 1) 
            p2.fireAttempt(); p2.fire = 0; end
            
        p1.checkStatus(p2); p2.checkStatus(p1);
        
        imagesc(-bg.length/2, -bg.length/2, bg.value);
        imagesc(p1.inMapX, p1.inMapY, p1.value);
        imagesc(p2.inMapX, p2.inMapY, p2.value);
        scatter(p1.shells.Xs, p1.shells.Ys, p1.shells.dia, p1.shells.color, 'filled');
        scatter(p2.shells.Xs, p2.shells.Ys, p2.shells.dia, p2.shells.color, 'filled');
        
        disp(p1.x);
        drawnow; % update plot
        pause(0.1);
    end
    
    close(1);
end

function init()
    global game;
    game.on = true;
    global bg;
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
    global p1; global p2;
    switch ed.Key
        case 'q'
            game.on = 0;
        % player one
        case 'leftarrow' 
            p1.x = p1.x - 1;
            p1.dir = "left";
        case 'rightarrow'  
            p1.x = p1.x + 1;
            p1.dir = "right";
        case 'uparrow' 
            p1.y = p1.y + 1;
            p1.dir = "up";
        case 'downarrow' 
            p1.y = p1.y - 1;
            p1.dir = "down";
        case 'l'
            p1.fire = 1;
    end
        
    % player two
    if (~ game.botMatch)
        switch ed.Key
            case 'a' 
                p2.x = p2.x - 1;
                p2.dir = "left";
            case 'd'  
                p2.x = p2.x + 1;
                p2.dir = "right";
            case 'w' 
                p2.y = p2.y + 1;
                p2.dir = "up";
            case 's' 
                p2.y = p2.y - 1;
                p2.dir = "down";
            case 'e' 
                p2.fire = 1;
        end
    end
end