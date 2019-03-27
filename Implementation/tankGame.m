%% main goes here

%loadingScreen()
main();

function main()
    % coordinates of tanks are the scale version in the plot
    % absolute coordinates are denoted by `inMapX` and `inMapY`

    global game;
    global bg; global p1; global p2;
    % p1 and p2 are human control, p3 is bot
    bg = background(16, 32); %unmber of units, pixel per unit
    p1 = tank(bg.scale - 2, bg.scale - 2, 'resources\tank1.png', bg); % arrow control
    p2 = tank(1, 1, 'resources\tank2.png', bg); % wasd control 
    init(); % initlizing parameters
    
    play(bg.music);
    loadingScreen();
    
    while(game.on)
        delete(get(gca,'Children')); %clear plot
        
        if game.botMatch
            p2.decision(); end
        
        if  (p1.fire == 1) 
            p1.fireAttempt(); p1.fire = 0; end
        if  (p2.fire == 1) 
            p2.fireAttempt(); p2.fire = 0; end
            
        p1.checkStatus(); p2.checkStatus();
        checkBullets(p1, p2);
        checkBullets(p2, p1);
        
        imagesc(0, 0, bg.value);
        imagesc(p1.inMapX, p1.inMapY, p1.value);
        imagesc(p2.inMapX, p2.inMapY, p2.value);
        scatter(p1.shells.Xs, p1.shells.Ys, p1.shells.dia, p1.shells.color, 'filled');
        scatter(p2.shells.Xs, p2.shells.Ys, p2.shells.dia, p2.shells.color, 'filled');
        
        if (p1.health <= 0)
            game.p1Streak = 0;
            if (game.lastWinner == "p2" || game.lastWinner == "null")
                game.p2Streak = game.p2Streak + 1;
            end
            game.lastWinner = "p2";
            respawn(p1);
        end
        if (p2.health <= 0)
            game.p2Streak = 0;
            if (game.lastWinner == "p1"  || game.lastWinner == "null")
                game.p1Streak = game.p1Streak + 1;
            end
            game.lastWinner = "p1";
            respawn(p2);
        end
        
        scoreBoardUpdate();
        drawnow; % update plot
        pause(0.1);
    end
    stop(bg.music)
    close(1);
end

%% Other Functions

function init()
    global game; global bg;
    global p1; global p2;
    p1.dir = "up"; p2.dir = "down";  % initial direction
    p1.opponent = p2; p2.opponent = p1; 
    
    game.on = true;    
    game.botMatch = 0;               % place holder for bot status
    game.UI = figure('menubar','none',...
               'numbertitle','off'); % cancel menu bar
    game.lastWinner = "null";        % for recording kill streak
    game.p1Streak = 0;
    game.p2Streak = 0;
    game.firstBlood = flip(imread('resources\firstBlood.png'));
    game.doubleKill = flip(imread('resources\doubleKill.png'));
    game.dominating = flip(imread('resources\dominating.png'));
           
    hold on;
    axis([0, bg.length + bg.extraLen * bg.multiplier, 0, bg.length])
    game.mainScreen = plot([0, bg.length], [0, bg.length]);
    
    set(gcf,'WindowKeyPressFcn',@pressKey);
    % use `set` instead of waitkey and get
    % bacasue `wait` and `get` would pause the game
    % thus the computer opponent would not be able to move
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
            
        case 'p'
            game.loading.index = game.loading.index - 1;
        case 'return'
            game.loading.undecided = 0;
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
        % because bullet trvals faster than tank
        % can't simply check if the coordinates are same
        % also have to check if the tank is within bullet hitting range
        if (i > length(pp1.shells.listOfBul)) 
            break 
        end
        xDist = pp1.shells.listOfBul(i).x - pp2.x;
        yDist = pp1.shells.listOfBul(i).y - pp2.y;
        switch pp1.shells.listOfBul(i).direction
            case "up"
                if (xDist == 0) && (yDist == 0 || yDist == 1)
                    % if hit, opponent's health minus one
                    % and elminate that bullet
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

function loadingScreen()
    % the screen before game
    global game;
    global bg;
    game.loading.bgImg = flip(imread('resources\baseselection.png'));
    game.loading.selImg = imread('resources\select.png');
    game.loading.undecided = 1; % looping condition 
    game.loading.index = 0;     % records user choice 
    
    game.loading.selectX = 4;   % x coordinate of arrow icon
    game.loading.selectY = 7;   % y coordinate of arrow icon
    
    set(gcf,'WindowKeyPressFcn',@pressKey);
    while(game.loading.undecided)
        delete(get(gca,'Children')); %clear plot
        imagesc(0, 0, game.loading.bgImg);
        xLoc = game.loading.selectX * bg.multiplier; % actual coordinate
        yLoc = (game.loading.selectY + rem(game.loading.index, 2)*2)* bg.multiplier;
        imagesc(xLoc, yLoc, game.loading.selImg);
        imagesc(bg.length, 0, bg.scoreBoard);
        drawnow;
        pause(0.1);
    end
    
    game.botMatch = ~rem(game.loading.index, 2); % interpretate user choice
end

function respawn(player)
    % if one tank lose all health, respawn 
    player.health = player.HPpool;
    player.x = player.birthX;
    player.y = player.birthY;
    player.lifes = player.lifes - 1;
end

function scoreBoardUpdate()
    global game; global bg; 
    global p1; global p2;
    p1Health = int2str(p1.health);
    p2Health = int2str(p2.health);
    offsetX = bg.length + 16;
    offsetY = bg.length - bg.multiplier - 16;
    imagesc(bg.length, 0, bg.scoreBoard);
    
    % title
    text(offsetX, offsetY, '  TANK', 'color', 'white')
    offsetY = offsetY - bg.multiplier; % move the position one block lower
    text(offsetX, offsetY, 'COMMANDER', 'color', 'white')
    offsetY = offsetY - 2*bg.multiplier; 
    
    % player one info
    text(offsetX, offsetY, 'Player 1:', 'color', 'white')
    offsetY = offsetY - bg.multiplier;
    text(offsetX, offsetY, '  Life: ', 'color', 'white')
    imgLocX = offsetX + 2*bg.multiplier; 
    for (i = 1 : p1.lifes) 
        imagesc(imgLocX, offsetY - 16, p1.oriValue);
        imgLocX = imgLocX + bg.multiplier;
    end
    offsetY = offsetY - bg.multiplier;
    text(offsetX, offsetY, ['  HP:   ' p1Health], 'color', 'white')
    offsetY = offsetY - bg.multiplier;
    if (game.p1Streak == 1) % ploting tank icon
        imagesc(offsetX, offsetY - 16, game.firstBlood);
    elseif (game.p1Streak == 2)
        imagesc(offsetX, offsetY - 16, game.doubleKill);
    end
    offsetY = offsetY - 2*bg.multiplier;
    
    % player two info
    text(offsetX, offsetY, 'Player 2:', 'color', 'white')
    offsetY = offsetY - bg.multiplier;
    text(offsetX, offsetY, '  Life: ', 'color', 'white')
    imgLocX = offsetX + 2*bg.multiplier;
    for (i = 1 : p2.lifes)
        imagesc(imgLocX, offsetY - 16, p2.oriValue);
        imgLocX = imgLocX + bg.multiplier;
    end
    offsetY = offsetY - bg.multiplier;
    text(offsetX, offsetY, ['  HP:   ' p2Health], 'color', 'white')
    imgLocX = offsetX + 2*bg.multiplier;
    if (game.p2Streak == 1)
        imagesc(offsetX, offsetY - 16, game.firstBlood);
    elseif (game.p2Streak == 2)
        imagesc(offsetX, offsetY - 16, game.doubleKill);
    end
end

