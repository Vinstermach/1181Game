%|Bouncing ball game
%|A good example of animation and real-time user interaction
% University of Tennessee : EF 230 Fall, 2009 : Will Schleter

function main
    close all; clc;
    format compact;

    % use a global structure to store all values that need to be
    % used in several different functions
    global g;

    get_settings();
    init_figure();
    create_ball();

    tic; % start timer
    while g.playing
        if g.moving == 0, tic; drawnow; continue; end
        if g.moving == 1, dt = toc; % get time since last bounce
        else, dt = .1; g.moving=0;
        end
        if dt < .05, continue; end % prevents updates of less than 1/20 of a second
        tic; % reset timer
        % new position and velocity
        g.cx = g.cx + g.vx*dt + .5*g.ax*dt*dt;
        g.cy = g.cy + g.vy*dt + .5*g.ay*dt*dt;
        g.vx = round(g.vx + g.ax*dt);
        g.vy = round(g.vy + g.ay*dt);
        % check for wall hits
        if (g.cx>g.xmax && g.vx>0) || (g.cx<0 && g.vx<0), g.vx=-g.cor*g.vx; beep; end
        if (g.cy>g.ymax && g.vy>0) || (g.cy<0 && g.vy<0), g.vy=-g.cor*g.vy; beep; end
        update_graphics
    end
    close(1)
    % msgbox('Thanks for playing')
 
return
 
 
function buttonpush(src, ed)
    global g
    dv = 10;
    if length(ed.Modifier)>0, dv=1; end  % shift, ctrl, alt all set dv=1
    switch ed.Key
        case 'q'
            g.playing=0;
        case 'space'
            if g.moving, g.moving=0;
            else, g.moving=1;
            end
        case 'r'
            if length(ed.Modifier)>0
                g.cor=max(.1,g.cor-.01);
            else
                g.cor=min(1,g.cor+.01);
            end
        case 'y'
            if length(ed.Modifier)>0
                g.ay=g.ay-10;
            else
                g.ay=g.ay+10;
            end
        case 'x'
            if length(ed.Modifier)>0
                g.ax = g.ax-10;
            else
                g.ax = g.ax+10;
            end
        case 'tab'
            g.moving = 2;
        case 'leftarrow'
            g.vx = g.vx-dv;
        case 'rightarrow'
            g.vx = g.vx+dv;
        case 'uparrow'
            g.vy = g.vy+dv;
        case 'downarrow'
            g.vy = g.vy-dv;
        otherwise
            fprintf(ed);  % show key info
    end

return
 
 
function get_settings
    global g;
    p = {'X acceleration','Y acceleration','Coef of restitution'}; %text displayed
    t = 'Bouncing Ball Game'; % titlr of window
    d = {'0','-100','1'};     % default value
    a = inputdlg(p,t,1,d);    %input dialog window
    if isempty(a), error('Cancelled'); end  % user pushed close or cancel
    g.ax = str2double(a{1});  %get value form the dialog window
    g.ay = str2double(a{2});
    g.cor = str2double(a{3});

    % hardcoded values
    % declare `g` as an global object and assign its attributes 
    g.playing = 1;
    g.moving = 1;
    g.xmax = 100;
    g.ymax = 100;
    g.cx = g.xmax*rand(1);  % starting position
    g.cy = g.ymax*rand(1);
    g.vx=0;  % starting velocity
    g.vy=0;
return
 
 
function create_ball
    global g;
    % create a 'ball'
    t = linspace(0,2*pi,20);   
    r = 2;                     % radius
    g.bx = r*cos(t); 
    g.by = r*sin(t);
    g.ball =  patch(g.bx,g.by,'r');

    % trace (tail)
    tlen = 50;
    g.trace.x = ones(1,tlen)*g.cx; % array of x coordinates
    g.trace.y = ones(1,tlen)*g.cy; % array of y coordinates
    g.trace.h = plot(g.trace.x,g.trace.y,'b:'); % plot the trace

    % velocity vector
    x = [g.cx g.cx];
    y = [g.cy g.cy];
    g.velvec.h = plot(x,y,'r-');
return
 
 
function init_figure
    % set up figure window
    global g;
    figure(1);
    hold on;
    axis equal;
    title('Bouncy Ball');
    axis([0 g.xmax 0 g.ymax]);
    axis off;
    rectangle('Position',[0,0,g.xmax,g.ymax])
    % set the function that gets called when a key is pressed
    set(gcf,'WindowKeyPressFcn',@buttonpush);
    % instructions
    text(102,90,{'Q: quit game',
        'space: pause/resume',
        'Tab: single step',
        'R: COR +.01',
        'sh-R: COR -.01',
        'X: Ax+10',
        'sh-X: Ax-10',
        'Y: Ay+10',
        'sh-Y: Ay-10',
        'Arrow keys:',
        ' "push" the ball'}, 'verticalalign','top' );
    % status text 
    g.stattext_h = text(-30,90,'','verticalalign','top');
return
 
 
function update_graphics
    global g;

    % move ball to new position
    set(g.ball,'XData',g.bx+g.cx);
    set(g.ball,'YData',g.by+g.cy);

    % update status text
    set(g.stattext_h,'String',...
        sprintf('Vx=%.0f\nAx=%.0f\nVy=%.0f\nAy=%.0f\nCOR=%.2f',...
                g.vx,g.ax,g.vy,g.ay,g.cor));

    % update trace
    g.trace.x=[g.cx g.trace.x(1:end-1)];
    g.trace.y=[g.cy g.trace.y(1:end-1)];
    set(g.trace.h,'XData',g.trace.x,'YData',g.trace.y);

    % update velocity vector
    x=[g.cx g.cx+g.vx/5];
    y=[g.cy g.cy+g.vy/5];
    set(g.velvec.h,'XData',x,'YData',y);

    % update display
    drawnow
return
