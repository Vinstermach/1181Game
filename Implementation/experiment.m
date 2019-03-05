%% main goes here
main();
function main()
    global g;
    init();
    
    while(g.gameOn)
        % ensure 
        if (g.x < -5) g.x = -5; end
        if (g.x > 5) g.x = 5; end
        if (g.y < -5) g.y = -5; end
        if (g.y > 5) g.y = 5; end
        
        set(g.ui,'XData',g.x);
        set(g.ui,'YData',g.y);
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
    
    hold on;
    
    axis([-5, 5, -5, 5]);
    g.ui = scatter(g.x, g.y);
    
    set(gcf,'WindowKeyPressFcn',@pressKey);
    drawnow
end

function pressKey(~, ed)
    global g;
    switch ed.Key
        case 'q'
            g.gameOn = 0;
        case 'leftarrow'
            g.x = g.x - 1;
        case 'rightarrow'
            g.x = g.x + 1;
        case 'uparrow'
            g.y = g.y + 1;
        case 'downarrow'
            g.y = g.y - 1;
    end
end
