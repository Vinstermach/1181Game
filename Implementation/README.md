# File explanation and pseudocode:  

* `background.m`: the class definition file for background.
* `basicStructure.m`: provides basic idea of implementing keyboard interaction in MatLab. 
* `bullet.m`: the class definition file for single bullet, including bullet coordinates and direction.
* `bullets.m`: the class definition file for all bullets - a collection of object instance `bullet`.
* `experiment.m`: just like the name, it is a temporary file providing experimental implementation, with no actual usage. 
* `tank.m`: the class definition file for tank. Decides how tank interact with the environment, also has the hard-coded AI algorithm. 
* `tankGame.m`: main game file. Run this file to start the game. 
  ``` python
  main() {
    initilize background;
    initilize player one's tank;
    initilize player two's tank;
    initilize the game parameter;
    
    start playing music;
    start displaying the start screen;
    
    while the game is on {
      clear former images; 
      
      if one of the 2 players' life is 0
        display ending screen;
      else {
        if it is a human vs. bot match
          let the bot make decision;
        
        if ant one of the players pressed fire key
          try to fire;
          
        check the 2 players' status;
        check if the bullets hit target;
        
        insert the image of background;
        insert the image of players' tank;
        draw the bullets; 
        
        if one player's HP is smaller or equal to 0 {
          decrease that player's life by 1;
          update the lastWinner and killStreak;  
          respawn that player;
        }
          
        update the score board;
        update the game screen;
        pause 0.1 second;
      }
    }
    stop the music;
    close the game window;
  }
  
  pressKey() { # the function to check the key pressed
    if q is prssed
      set the game status to off;
    if arrow keys are pressed
      move player one;
    if L key is pressed
      let player one try to fire;
      
    if O key is pressed
      move the option icon;
    if Enter key is pressed
      confirm current option;
    
    if the game is not human vs. bot {
      if WASD keys are pressed
        move player two;
      if L key is pressed
        let player one try to fire;
    }
  }
  
  checkBullet() { # check if the bullets hit target;
    iterate through the bullets {
      if bullet trevals out of effective range: 
        delete that bullet;
      if the bullet's coordinates meets the tank's coordinates {
        decrease tank's HP by 1;
        delete that bullet;
      }  
    } 
  }
  
  startScreen() { # start displaying the start screen;
    while the user havn'e make decision {
      clear former images; 
      display image asking whether player want to play against bot or another player;
      display the selection icon; 
      update the game screen;
      pause 0.1 second;
    }
    get user decision; 
  }
  
  respawn() {
    reset player location;
    reset player HP;
    decrease player lifes by 1;
  }
  
  scoreboardUpdate() {
    display players' remaining lifes;
    display players' HP;
    if there's killing streak
      display killing streak; 
  }
  
  endingScren() {
    display the winner;
    while the user havn'e make decision {
      clear former images; 
      display image asking if the player want another round;
      display the selection icon;
      update the game screen;
      pause 0.1 second;
    }
    get user decision; 
  }
  ```

# Current goal of game implementation  

1. empty HP after death
2. A better Computer opponent algorithm 
3. Killing streak and appearance improvement




