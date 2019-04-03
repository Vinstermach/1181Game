

%% main goes here
main();

function main()
    global game;  % declare an object called game 
    global fuck;
    init(); % initlizing
    fuck = music();
    
    while(game.on)
        drawnow % update plot
    end
    
    close(1) 
end


%% funtions goes here
function init() 
    global game;
    game.x = 0;  
    game.y = 0;  
    game.on = 1; 
    
    hold on; 
    
    axis([-5, 5, -5, 5]); % define scope
    game.ui = scatter(game.x, game.y); 
    
    set(gcf,'WindowKeyPressFcn',@pressKey);
end

function pressKey(~, ed)
    global game;  
    global fuck;
    switch ed.Key 
        case 'escape'
            game.on = 0;
        case 'q' 
            fuck.tone(8, 100);
        case 'w' 
            fuck.tone(7.5, 100);
        case 'e' 
            fuck.tone(7, 100);
        case 'r' 
            fuck.tone(6.5, 100);
        case 't' 
            fuck.tone(6, 100);
        case 'y' 
            fuck.tone(5.5, 100);
        case 'u' 
            fuck.tone(5, 100);
        case 'i' 
            fuck.tone(4.5, 100);
            
        case 'a' 
            fuck.tone(8, 200);
        case 's' 
            fuck.tone(7.5, 200);
        case 'd' 
            fuck.tone(7, 200);
        case 'f' 
            fuck.tone(6.5, 200);
        case 'g' 
            fuck.tone(6, 200);
        case 'h' 
            fuck.tone(5.5, 200);
        case 'j' 
            fuck.tone(5, 200);
        case 'k' 
            fuck.tone(4.5, 200);
            
        case 'z' 
            fuck.tone(8, 300);
        case 'x' 
            fuck.tone(7.5, 300);
        case 'c' 
            fuck.tone(7, 300);
        case 'v' 
            fuck.tone(6.5, 300);
        case 'b' 
            fuck.tone(6, 300);
        case 'n' 
            fuck.tone(5.5, 300);
        case 'm' 
            fuck.tone(5, 300);
        case ',' 
            fuck.tone(4.5, 300);
    end
end

