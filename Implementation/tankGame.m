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
    bg = background(16, 32); %unmber of units, pixel per unit
    p1 = tank(bg.scale - 2, bg.scale - 2, 'resources\tank1.png', bg); % arrow control
    p2 = tank(1, 1, 'resources\tank2.png', bg); % wasd control 
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
        checkBullets(p1, p2);
        checkBullets(p2, p1);
        
        imagesc(0, 0, bg.value);
        imagesc(p1.inMapX, p1.inMapY, p1.value);
        imagesc(p2.inMapX, p2.inMapY, p2.value);
        scatter(p1.shells.Xs, p1.shells.Ys, p1.shells.dia, p1.shells.color, 'filled');
        scatter(p2.shells.Xs, p2.shells.Ys, p2.shells.dia, p2.shells.color, 'filled');
        
        if (p1.health <= 0)
            game.lastWinner = "p2";
            game.p2Streak = game.p2Streak + 1;
            break;
        end
        if (p2.health <= 0)
            game.lastWinner = "p1";
            game.p1Streak = game.p1Streak + 1;
            break;
        end
        
        drawnow; % update plot
        pause(0.1);
    end
    
    f = msgbox("Winner is " + game.lastWinner);
    close(1);
end

%% Other Functions
function init()
    global game;
    game.on = true;
    global bg;
    game.UI = figure('menubar','none',...
               'numbertitle','off');
    game.lastWinner = "Null";
    game.p1Streak = 0;
    game.p2Streak = 0;
           
    hold on;
    axis([0, bg.length, 0, bg.length])
    game.mainScreen = plot([0, bg.length], [0, bg.length]);
    
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
            p1.move("left");
        case 'rightarrow'  
            p1.move("right");
        case 'uparrow'       
            p1.move("up");
        case 'downarrow' 
            p1.move("down");
        case 'l'
            p1.fire = 1;
    end
    
    % player two
    if (~ game.botMatch)
        
        switch ed.Key
            case 'a' 
                p2.move("left");
            case 'd'  
                p2.move("right");
            case 'w' 
                p2.move("up");
            case 's'             
                p2.move("down");
            case 'e' 
                p2.fire = 1;
        end
    end
end

function checkBullets(pp1, pp2)
    % check if pp1's bullets hit pp2, if so, decrease pp2's HP
    
    % shittiest function ever
    % due to the weird memory management of Matlab
    for i = 1 : length(pp1.shells.listOfBul)
        xDist = pp1.shells.listOfBul(i).x - pp2.x;
        yDist = pp1.shells.listOfBul(i).y - pp2.y;
        switch pp1.shells.listOfBul(i).direction
            case "up"
                if (xDist == 0) && (yDist == 0 || yDist == 1)
                    pp2.health = pp2.health - 1;
                    pp1.shells.listOfBul(i) = [];
                end
            case "down"
                if (xDist == 0) && (yDist == 0 || yDist == -1)
                    pp2.health = pp2.health - 1;
                    pp1.shells.listOfBul(i) = [];
                end
            case "left"
                if (xDist == 0 || xDist == -1) && (yDist == 0)
                    pp2.health = pp2.health - 1;
                    pp1.shells.listOfBul(i) = [];
                end
            case "right"
                if (xDist == 0 || xDist == 1) && (yDist == 0)
                    pp2.health = pp2.health - 1;
                    pp1.shells.listOfBul(i) = [];
                end
        end
    end
end
