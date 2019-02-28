%not working yet 

%% main goes here
main();
function main()
    global g;
    init();
    
    while(g.gameOn)
        %set(g.x, 'XData', g.x + 1);
        %set(g.y, 'yData', g.y + 1);
        drawnow
    end
    
    close(1)
end


%% funtions goes here
function init()
    global g;
    g.x = 0;
    g.y = 0;
    g.gameOn = 1;
    
    figure(1);
    hold on;
    
    axis([-5, 5, -5, 5]);
    scatter(g.x, g.y);
    
    set(gcf,'WindowKeyPressFcn',@pressKey);
end

function pressKey(~, ed)
    global g;
    switch ed.Key
        case 'q'
            g.gameOn = 0;
        case 'leftarrow'
            g.x = g.x - 1;
        case 'rightarrow'
            g.vx = g.x + 1;
        case 'uparrow'
            g.y = g.y + 1;
        case 'downarrow'
            g.y = g.y + 1;
    end
end


