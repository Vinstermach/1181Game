
# File Explaination #

## `background.m` ##
This file is the class definition for background. reads background images and musics for the game. It also decides the size of the background map and how it is oragnized. 

* Function `background(Scale, Multiplier, punk)` initilize the object attributes and read files necessary for the game.   
Depending on the input parameter, it might also read different pictures for a different visual style.

* Function `generateImage(obj)` generate a image based on 2 arrays of the location of grass and brick blocks. 
It first creat a blank image, then the `for` loop goes through every entries in the matrix, `if` the value indicates a block, 
then replace the value of a certain aera in that blank image with the image of the block. 

* Function `resetMap(obj)` randomly pick one from three map plans and set the picked one as current map.

* Function `getMusic(obj, path)` is created to read the background music and calculate it's length.

* Function `readArray(obj)` records the matrices of all map plans, it is created mainly for the sake of the coder, 
as these matrices are large and MatLab generally does not have a good folding mechanism.

## `tank.m` ##
This file is the class definition for player tanks. It contains basic instructions like move or shoot, also contains the algorithm of bot.

* Function `tank(X, Y, Path, BG)` initilize the object attributes like life and HP, reads the icon image and the environment this tank is in. 

* Function `checkStatus(obj)` first count down the time before next shoot.   
Then using several `if-elseif` statements check the direction of the tank, ratate the tank image to the facing direction. 
Next it upadtes the tank's location in the map by multipling the coordinates with the pixel ratio of the game. 
At last it invokes ~~wex-wex-exort Alacrity to let the player experience true swiftness~~ `updateBullets()` 
to check the status of all the bullets shot by this tank. 

* Function `opponentAhead(obj, direction)` is used to determine whether the opponent is in front of the player.   
It uses several `if-elseif` statements, check if the opponent's location is 1 unit ahead of this tank. 
Retuens true if the opponent is 1 units ahead, otherwise returns false. 

* Function `move(obj, direction)` is used to ensure the tank don't go outside the map of stuck into a wall.  
It `switch` throught the facing direction the tank, it the tank wants to move and there's nothing ahead, 
then change the `x` or `y` value of the tank so that it would move. 

* Function `decisionAdvanced(obj)` is used to let the bot make decision. 
It creats 4 variables representing the weight of 4 possible move directions: up, down, left, right.   
It first use `if-elseif` statements add the distance between the tank and its opponent, 
thus the bot will most likly to move according to the direction that has the longest distance with the opponent, 
in order to decrease the distance with its opponent. 
Then every 4 weights is added a random value to make sure these weights' value would not be the same. 
Next the values are masked with the map. Meaning that if left side cannot be reached, then the bot would not make decision to move left.  
Lastly it `switch` throught the weight and move to the direction with highest value. 
After that it uses several nested `if` to determine is the opponent is right in front, and if so, try to shoot the opponent. 

## `tankGame.m` ##
This file runs the game. 

* Function `main()` is the function that runs the game.   
It creates 1 instance of class `backgound` and 2 instances of class `tank`, 
also creates an object called `game` to records variables through out the game. 
After `init()`, it started to play music ang goes into `loadingScreen()`. 
After the loading screen, it goes into a `while` loop for the interactive gaming.  
Inside each loop, it first checks if the music is finished by comparing the length of music and the time since the music started to play. 
, if yes, then restart the music.  
Then it checks if the game is paused, if so, go to `pauseScreen()`. If not, continuing calculating.   
The calculating includes first check if that's a PvE mathc, if so, let the bot make a `decisionAdvanced()`. 
If any player pressed (or decided) to shoot, examine whether they are ablr to shoot by invoking `fireAttempt()`. 
Then invoking `checkStatus()` and `checkBullets(pp1, pp2)` to check the player and their bullets' status.  
Next it draw the map and tanks by using `imagesc`. And draw bullets by using `scatter`.   
After that, it checks the HP of the players, if one of the player's HP hit 0, then decrease the life of that player, 
if it's life haven't been used up, then let it respawn.   
At last it updates the entire plot by `drawnow`.   
Outside the loop, it ends the music ` stop(bg.music)` and close the figure `close(1)`.

* Function `init()` sets the parameters of the game, initilize the figure, deltes the label on both x and y axis, 
also elimates the menu bar of the plot. 

* Function `pressKey(~, ed)` associates key pressing event with the game, provides keyboard interaction for the game. 

* Function `checkBullets(pp1, pp2)` checks the bullets shot by `pp1`, see if they hit player `pp2`.  
Because the bullets moves faster than tank _(normally)_, 
it could not simply check if the coordinates of the bullets and the tank are same, 
thus it fist use a `for` loop iterate every bullets shot by tank `pp1` 
(By altering parameters, it is possible that the tank shots multiple bullets). 
Then uses a `switch` goes through the direction of the bullet, if the bullet's location is the same 
or 1 unit ahead of the opponent, that indicates the opponent got hit, then decrase the HP of opponent and delete that bullet. 

* Function `loadingScreen()` is the screen for player to choose mode and display control info.  
It first read the image of the loading screen then goes into a `while` loop. 
Inside each loop, it refresh the plat and draw the selcting icon by using `imagesc`.  
After the user make his/her decision, it reads the user's decision (PvP or PvE) and return to `main()`.

* Function `respawn(player, resetLife)` reset the parameters, including location and HP to original. Also decrease the life by one. 

* Function `scoreBoardUpdate()` updates the scoreboard at the right side of the game pannel.   
It first use a `switch` to obtain the killing streak image of both players. 
Then insert picture (`imagesc()`) of the tank icon to represent lifes left. And texts (`text()`) of the players' status. 

* Function `ending()` is the ending screen showed when one player's life hit 0. It asks whether the user want to play another round.    
It first pick some random text depending on who wins and wether it's player against computer. Followed by a `while` loop.   
inside the loop, it refresh the plot and draw the selcting icon by using `imagesc`.
After the loop, it reads user decision, if the user wants to play another round, then it reset all parameters of the game and back to `main()`.

* Function `pauseScreen()` pop up when player hits `P`.   
It goes directly into a `while` loop. Inside the loop it refresh the plot and draw the selcting icon by using `imagesc`. 
Whenever the user hit `Enter`, it reads current selection and does corresponding operation. 
Some resets the music, others open external links.   
If the player hits `P` again, the while loop would break and back to `main()`.

## `bullet.m` ##
This file is the class definition for `bullet`.   

* Function `bullet(Direction, StartX, StartY)` creates a new bullet, recording its initial position and direction. 

## `bullets.m` ##
This file is the class definition for `bullets`, which is a collection of class `bullet`. 

* Function `bullets(effectiveRange)` intilize the object. With the only input parameter `effectiveRange` determines the range inside which the bullet is considered effective. 

* Function `updateBullets(obj)` examines thestatus of bullets.   
It first iterate through all bullets in the collection by a `for` loop. If the bullet's moving direction has no wall, 
then move the bullet 1 unit; otherwise delete that bullet. repeat that process twice so the bullet moves faster than tank.   
Then it multiplies the corrdinates by the pixel ratio, so the bullets can be plotted correctly. 



