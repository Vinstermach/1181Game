classdef laser
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
        function obj =laser(x,y)
            %Create the player's spaceship. The object gamedata.mat is
            %previously generated sprites.
            load('gamedata.mat')            
            obj.x=x;
            obj.y=y;
            %Velocity
            obj.vx=2;
            obj.vy=2;
            %Rotation
            obj.angle=0;
            %These are for drawing laser a little bit to the rigth or to
            %the left
            if rand()>0.5
            obj.mainspritefaces=laser1faces;
            obj.mainspriteverts=laser1verts;
            obj.mainspritecdata=laser1cdata;
            else
            obj.mainspritefaces=laser2faces;
            obj.mainspriteverts=laser2verts;
            obj.mainspritecdata=laser2cdata;
            end
            obj.life=1;%Life is used to delete the object after a while.           
        end
        
        function obj=draw(obj)
            %Spaceship is draw as a patch object.            
            obj.drawing= patch('Faces',obj.mainspritefaces,'Vertices',obj.mainspriteverts,'FaceColor','flat','FaceVertexCData',obj.mainspritecdata,'EdgeColor','none');
            obj=update(obj);
        end
        
        function obj=update(obj)
            %This function moves or rotates the sprite to the position held by the object.               
            %In order to prevent sprite deformation after several
            %transformations, we allways transform vertex from original
            %ones.
            b(:,1)=obj.mainspriteverts(:,1).*cos(obj.angle)-obj.mainspriteverts(:,2).*sin(obj.angle);
            b(:,2)=obj.mainspriteverts(:,1).*sin(obj.angle)+obj.mainspriteverts(:,2).*cos(obj.angle);
            a=get(obj.drawing,'Vertices');           
            a(:,1)=obj.x;
            a(:,2)=obj.y;            
            set(obj.drawing,'Vertices',b+a); 
            obj.life=obj.life-1/30;        
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