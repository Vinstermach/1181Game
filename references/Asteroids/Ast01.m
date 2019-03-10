%Version 0.1 (beta, so please, give feedback).
%
%This is a game and also an example of how to read/use keypress
%functionality from figures.
%
%This is a tribute to Asteroids[1], without any lucrative pourpouse.
%
%The game opens a figure with the spaceship that must destroy the asteroids
%avoiding being hit.
%
%Use the mouse to point where the spaceship is facing and spacebar to start the engine
%fire with mouse click and Q for exit.
%
%
%  References:
%  [1] Asteroids, Game,
%      http://en.wikipedia.org/wiki/Asteroids_%28video_game%29
%
%This function was written by :
%                             Héctor Corte
%                             B.Sc. in physics 2010
%                             M.Sc. in Complex physics systems 2012
%                             NPL (National Physical Laboratory), London,
%                             United kingdom.
%                             Email: leo_corte@yahoo.es
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = Ast01()
%----------------------CONSTANTS----------------------
%game settings
dt=0.1;
FIGURE_WIDTH = 800; %pixels
FIGURE_HEIGHT = 480;
%appearance
FIGURE_COLOR = [0, 0, 0]; %program background
AXIS_COLOR = [.15, .15, .15]; 
%----------------------VARIABLES----------------------
quitGame = false; %guard for main loop. when true, program ends
gamestarted=0;
objects=cell(1);%This will contain all the objects in the game: spaceship, asteroids and lasers
%This is the spaceship
objects{1}=spaceship();
m=1; %This is the number of objects in the game, counting spaceship, laser beams and asteroids
lapse=0;
score=0;
h=[];
C=[0,0];
%-----------------------SUBROUTINES----------------------
%------------createFigure------------
%sets up main program figure
%called once at start of program
    function createFigure
        %ScreenSize is a four-element vector: [left, bottom, width, height]:
        scrsz = get(0,'ScreenSize');
        fig = figure('Position',[(scrsz(3)-FIGURE_WIDTH)/2 ...
            (scrsz(4)-FIGURE_HEIGHT)/2 ...
            FIGURE_WIDTH, FIGURE_HEIGHT],'CloseRequestFcn','quitGame=true;','BackingStore','on');
        %register keydown keyup and mousemotion listeners
        set(fig,'KeyPressFcn',@keyDown, 'KeyReleaseFcn', @keyUp ,'WindowButtonMotionFcn', @mouseMove, 'WindowButtonDownFcn',  @mouseClick);
        %figure can't be resized
        set(fig, 'Resize', 'off');
        axis([-5 5 -5 5]);
        axis manual;
        %set color for the court, hide axis ticks.
        set(gca, 'color', AXIS_COLOR, 'YTick', [], 'XTick', []);
        %set background color for figure
        set(fig, 'color', FIGURE_COLOR);
        hold on;
        %draw background
        
        plot(10*rand(50,1)-5,10*rand(50,1)-5,'ws','MarkerFaceColor','w');
        
        %draw spaceship
        objects{1}=draw(objects{1});
        %draw score
        h=title(sprintf('Score %06d  Lifes %d',score,objects{1}.life),'color',[1,1,1] );
    end
%------------refreshPlot------------
%Objects has representation in the plot, this is for updating positions
%Calls the update function defined for each class and makes the space
%cyclic.
    function refreshPlot
        for k=1:m
            objects{k}=update(objects{k});
            if objects{k}.x<-5
                objects{k}.x=5;
            end
            if objects{k}.x>5
                objects{k}.x=-5;
            end
            if objects{k}.y<-5
                objects{k}.y=5;
            end
            if objects{k}.y>5
                objects{k}.y=-5;
            end
        end
        set(h,'string',sprintf('Score %06d   Lifes %d',score,objects{1}.life) );
        pause(dt); %By pausing the game a certain amount of time we fix the speed of the game (at least in fast computers).
    end
%------------update------------
%Updates positions of objects
%clear objects that no longer exists
%create new asteroids when one is desintegrated
%destroys asteroids hitted by laser beams
    function update_objects
        dist=0;
        p=0;
        n=0;
        %We cycle all the objects in the game to update their position
        %We cycle in reverse because if an object is deleted from the list,
        %then it is not possible to cycle it
        for k=0:m-1
            objects{m-k}=physics(objects{m-k},dt);            
            if isa(objects{m-k},'laser')==1
                for j=2:m
                    %For each laser beam we check if it has hit an asteroid
                    if isa(objects{j},'asteroid')==1
                        dist=sqrt((objects{m-k}.x-objects{j}.x)^2+(objects{m-k}.y-objects{j}.y)^2);
                        if objects{m-k}.life>0
                            if dist<1                                
                                objects{m-k}.life=objects{m-k}.life-1;                                
                                objects{end+1}=asteroid(objects{j}.x,objects{j}.y,objects{j}.life-1);
                                objects{end}=draw(objects{end});
                                objects{end}.vx=objects{end}.vx+0.001*score/100*objects{end}.vx;
                                objects{end}.vy=objects{end}.vy+0.001*score/100*objects{end}.vy;
                                objects{end+1}=asteroid(objects{j}.x,objects{j}.y,objects{j}.life-1);
                                objects{end}=draw(objects{end});
                                objects{end}.vx=objects{end}.vx+0.001*score/100*objects{end}.vx;
                                objects{end}.vy=objects{end}.vy+0.001*score/100*objects{end}.vy;
                                objects{j}.life=-1;
                                p=p+2;
                                score=score+100;
                                crash
                            end
                        end                        
                    end
                end
            end            
            %For each laser beam we check if it has hit an asteroid
            if m-k==1                
                for j=2:m
                    %We check if the spaceship has been hit by an asteroid
                    if isa(objects{j},'asteroid')==1
                        dist=sqrt((objects{m-k}.x-objects{j}.x)^2+(objects{m-k}.y-objects{j}.y)^2);                        
                        if dist<0.5
                                                        objects{m-k}.life=objects{m-k}.life-1;
                                                        objects{j}.life=-1;                            
                            score=score+100;
                            crash;                            
                        end                        
                    end
                end                
            end
        end        
        m=m+p;        
        for k=0:m-2
            if objects{m-k}.life<=0                       
                    delete(objects{m-k});
                    objects(m-k)=[];                    
                    n=n+1;               
            end         
                    end
        m=m-n;        
                        if objects{1}.life==0
                    %A special case happens if the spaceship is destroyed.                    
                    for g=0:m-2                        
                        delete(objects{m-g});
                        objects(m-g)=[];                        
                    end   
                    m=1;
                    objects{1}.life=3;
                    newGame                    
                        end        
        if objects{1}.fire==1
            engine_sound;
        end
    end
%------------mouse movement------------
%Listener registered in createFigure
%listens for mouse input and rotates the spaceship to face the mouse
%pointer
    function mouseMove(src,event)
        C = get (gca, 'CurrentPoint');
        if gamestarted==1;
            %If this function starts before we create the spaceship, then it
            %will return an error.
            v=[C(1,1),C(1,2)]-[ objects{1}.x ,objects{1}.y];
            theta=atan2(v(2),v(1));
            objects{1}.angle=theta-pi/2;
        end
    end
%------------mouse click------------
%Listener registered in createFigure
%listens for mouse clicks and shoot laser beams
    function mouseClick(src,event)
        %This creates lasers
        if gamestarted==1;
            objects{end+1}=laser(objects{1}.x,objects{1}.y);
            objects{end}.angle=objects{1}.angle;
            objects{end}=draw(objects{end});
            objects{end}.vx=-4*sin(objects{end}.angle);
            objects{end}.vy=4*cos(objects{end}.angle);
            m=m+1;
        end
    end
%------------keyDown------------
%listener registered in createFigure
%used to stop the engine
    function keyDown(src,event)
        switch event.Key
            case 'space'
                objects{1}.fire=1;
            case 'r'
                %newGame;
            case 'q'
                quitGame = true;
        end
    end
%------------keyUp------------
%listener registered in createFigure
%used to stop the engine
    function keyUp(src,event)
        switch event.Key
            case 'space'
                objects{1}.fire=0;
        end
    end
%------------newGame------------
%This is the start screen with title
    function newGame
        h1=text(-3.9,4.1,'Asteroids','color','w','FontSize',80);
        h2=text(-4,4,'Asteroids','color',[0.4 0.4 0.4],'FontSize',80);
        h3=text(-4,2,'Press Any Key to Start','color','w','FontSize',30);
        h4=text(-4,1,'Space = Engine Mouse = turn spaceship Q = Exit','color',[0.4,0.4,0.4],'FontSize',10);
        pause(5*dt);
        waitforbuttonpress
        score=0;
        delete(h1);
        delete(h2);
        delete(h3);
        delete(h4);
    end
%------------engine_sound------------
%This is for playing a sound when the engine is on
    function engine_sound
        %This is to generate the sound of the enegine when it fires.
        cf = 100;                  % carrier frequency (Hz)
        sf = 22050;                 % sample frequency (Hz)
        n = sf * dt;                 % number of samples
        s = (1:n) / sf;             % sound data preparation
        s = sin(2 * pi * cf * s).*cos(cf*s)+0.01*rand(1,n).*cos(4*cf*s);  %Some strange noise
        sound(s, sf);               % sound presentation
    end
%------------crash------------
%This is for playing a sound in the event of spaceship crashing or if an
%asteroid is being destroyed.
    function crash
        %This is to generate the sound when the ship crashes.
        cf = 200;                  % carrier frequency (Hz)
        sf = 22050;                 % sample frequency (Hz)
        n = sf * dt;                 % number of samples
        s = (1:n) / sf;             % sound data preparation
        s = sin(3 * pi * cf * s).*cos(cf*s)+0.01*rand(1,n).*cos(8*cf*s);  %Some strange noise
        sound(s, sf);               % sound presentation        
    end
%----------------------MAIN SCRIPT----------------------
createFigure;%Creates the figure an background
newGame;%Shows the title screen
gamestarted=1;
while ~quitGame
    %This is the main loop
    update_objects;
    refreshPlot;
    lapse=lapse+dt;
    if lapse>(2-0.01*score/100)
        %This is for creating new asteroids
        objects{end+1}=asteroid(objects{1}.x+1+5*rand(),objects{1}.y+1+5*rand(),floor(3*rand()));
        objects{end}=draw(objects{end});
        objects{end}.vx=objects{end}.vx+0.01*score/100*objects{end}.vx;
        objects{end}.vy=objects{end}.vy+0.01*score/100*objects{end}.vy;
        m=m+1;
        lapse=0;
    end
end
delete(gcf)
end
