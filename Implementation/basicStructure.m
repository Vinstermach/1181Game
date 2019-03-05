% try not altering this file

%% main goes here
main();

function main()
    global game;  % declare an object called game 
    
    init(); % initlizing
    
    while(game.on)
        set(game.ui,'XData',game.x);
        set(game.ui,'YData',game.y);
        drawnow
    end
    
    close(1)
end


%% funtions goes here
function init()
    global game; % still using the global object `game`
    game.x = 0;  % x coordinate
    game.y = 0;  % y coordinate
    game.on = 1; % boolean condition for game status
    
    figure(1);
    hold on;
    
    axis([-5, 5, -5, 5]); % define scope
    game.ui = scatter(game.x, game.y); 
    % declare a scatter plot as a sub-object of `game`
    
    set(gcf,'WindowKeyPressFcn',@pressKey);
    % associate figure with key pressing
    % gcf returns the handle of the current figure
end

function pressKey(~, ed)
    global game;  % still referencing to the game object
    switch ed.Key % key pressed
        case 'q'
            game.on = 0;
        case 'leftarrow'
            game.x = game.x - 1;
        case 'rightarrow'
            game.x = game.x + 1;
        case 'uparrow'
            game.y = game.y + 1;
        case 'downarrow'
            game.y = game.y - 1;
    end
end

