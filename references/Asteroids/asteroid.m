classdef asteroid
    %This is a classdef to use with Ast01 game.
    properties
        x
        y
        vx
        vy
        angle
        mainspritefaces
        mainspriteverts
        mainspritecdata
        firefaces
        fireverts
        firecdata
        drawing
        life
        
    end
    methods
        function obj =asteroid(x,y,l)
            %Create the player's spaceship. The object gamedata.mat is
            %previously generated sprites.
            load('gamedata.mat')
            obj.x=x;
            obj.y=y;
            %Velocity
            obj.vx=0.5*rand()-0.25;
            obj.vy=0.5*rand()-0.25;
            %Rotation
            obj.angle=2*pi*rand();
            %These are for drawing
            a=rand();
            if a>0.75
                obj.mainspritefaces=ast1faces;
                obj.mainspriteverts=ast1verts;
                obj.mainspritecdata=ast1cdata;
            elseif a>5
                obj.mainspritefaces=ast2faces;
                obj.mainspriteverts=ast2verts;
                obj.mainspritecdata=ast2cdata;
            elseif a>25
                obj.mainspritefaces=ast3faces;
                obj.mainspriteverts=ast3verts;
                obj.mainspritecdata=ast3cdata;
            else
                obj.mainspritefaces=ast4faces;
                obj.mainspriteverts=ast4verts;
                obj.mainspritecdata=ast4cdata;
            end
            obj.life=l;
            obj.mainspriteverts=obj.life*obj.mainspriteverts;
        end
        function obj=draw(obj)
            %Spaceship is draw as a patch object.
            obj.drawing= patch('Faces',obj.mainspritefaces,'Vertices',obj.mainspriteverts,'FaceColor','flat','FaceVertexCData',obj.mainspritecdata,'EdgeColor','none');
            obj=update(obj);
        end
        function obj=update(obj)
            %This function moves or rotates the sprite to the position held by the spaceship.
            %In order to prevent sprite deformation after several
            %transformations, we allways transform vertex from original
            %ones.
            b(:,1)=obj.mainspriteverts(:,1).*cos(obj.angle)-obj.mainspriteverts(:,2).*sin(obj.angle);
            b(:,2)=obj.mainspriteverts(:,1).*sin(obj.angle)+obj.mainspriteverts(:,2).*cos(obj.angle);
            a=get(obj.drawing,'Vertices');
            a(:,1)=obj.x;
            a(:,2)=obj.y;
            set(obj.drawing,'Vertices',b+a);
        end
        function obj=physics(obj,dt)
            %Update the position.
            obj.x=obj.x+obj.vx*dt;
            obj.y=obj.y+obj.vy*dt;
        end
        function delete(obj)
            delete(obj.drawing);
            
        end
        
    end
end