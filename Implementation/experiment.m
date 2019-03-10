%% main goes here
main();

function main()
    g = plot([1, 2], [3, 4]);
    clf(g)
    pause(2)
    g = plot([4, 5], [4, 5]);
end


%% funtions goes here
function init()
    global g;
    g.xLen = 20;
    g.yLen = 20;
    g.x = 0;
    g.y = 0;
    g.gameOn = 1;
    g.bgImg.path = 'img.png';
    g.bgImg.format = 'png';
    g.icon.path = 'icon.png';
    g.icon.format = 'png';
    g.icon.size = 0.002;
    g.mainFig = figure('menubar','none',...
               'numbertitle','off');
              
    hold on;
    axis([-g.xLen, g.xLen, -g.yLen, g.yLen]);
    
    [g.bgImg.raw, g.bgImg.map, g.bgImg.alpha] = imread(g.bgImg.path, g.bgImg.format);
    g.bgImg.resized = imresize(g.bgImg.raw, 0.02);
    [g.icon.raw, g.icon.map, g.icon.alpha] = imread(g.icon.path, g.icon.format);
    g.icon.resized = imresize(g.icon.raw, g.icon.size);
    
    g.ui = scatter(g.x, g.y, 'ro', 'filled');
    
    set(gcf,'WindowKeyPressFcn',@pressKey);
    set(gca,'xtick',[]); set(gca,'xticklabel',[]);
    set(gca,'ytick',[]); set(gca,'yticklabel',[]);
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
