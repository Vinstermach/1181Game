%% main goes here
main();
function main()
    global g;
    init();
    
    while(g.gameOn)
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
    
    figure(1);
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
            fprintf("left pressed, gx now %d \n",g.x);
            return
        case 'rightarrow'
            g.x = g.x + 1;
            return
        case 'uparrow'
            g.y = g.y + 1;
            return
        case 'downarrow'
            g.y = g.y - 1;
            return
    end
end
