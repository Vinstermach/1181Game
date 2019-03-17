%% main goes here

%loadingScreen()
main();

function main()
    global game;
    game.botMatch = 1; % whether it's pve or pvp
    global bg; global p1; global p2;
    % p1 and p2 are human control, p3 is bot
    bg = background(25, 32, 'resources\basebackground.png'); %unmber of units, pixel per unit
    p1 = tank(bg.scale/2 - 2, bg.scale/2 - 2, 'resources\tank1.png');
    p2 = tank(-bg.scale/2 + 1, -bg.scale/2 + 1, 'resources\tank2.png');
    p1.dir = "up"; p2.dir = "up";
    
    init(); % initlizing parameters
    
    while(game.on)
        delete(get(gca,'Children')); %clear plot
        
        if game.botMatch
            p2.decision(p1); end
        
        p1.checkStatus(bg); p2.checkStatus(bg);
        
        imagesc(-bg.length/2, -bg.length/2, bg.value);
        imagesc(p1.inMapX, p1.inMapY, p1.value);
        imagesc(p2.inMapX, p2.inMapY, p2.value);
        
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
        case '?'
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
