`background.m`
```matlab
Property variables:
  scale;       % number of units 
  multiplier;  % the pixel of each unit 
  mLength;     % the number of blocks per dimensions 

  punkMode;    % whether use another set of image

  grassImg;    % the image for grass block
  brickImg;    % the image for brick block
  instrImg;    % image ised in loading screen
  scoreBoard;  % image used during game
  ending;      % image used in ending screen
  value;       % the final image
  borderArray; % the border of the battlefield 
  grassMatrix; % boolean matrix recording where are the grass blocks
  brickMatrix; % boolean matrix recording where are the brick blocks
  barriers;    % blocks that the tanks cannot reach 
  extraLen;    % extend the canvas for score board 
  soundTrack;  % music data 
  musicLen;    % length of the music
  music;       % the actual music player 

  grassAlt;    % several matrices of location of grass blocks
  brickAlt;    % several matrices of location of brick blocks
  p1Win;       % image for p1's winning 
  p2Win;       % image for p2's winning 
  aiWin1;      % image for bot's winning 
  aiWin2;      % alterante image for bot's winning 
  
Other variables:
  ary          % musics for orginary play
  aryPunk      % musics for punk play
  img          % blank image for background
  level        % random variable deciding which map to use
```


`bullet.m`
```matlab
Property variables:
  direction;    % direction of the bullet
  traveled = 0; % distance traveled 
  startX;       % starting x coordinate of where the bullet 
  startY;       % starting y coordinate of where the bullet 
  x;            % current x coordinate
  y;            % current x coordinate
```


`bullets.m`
```matlab
Property variables:
  bg;         % background, or to say the environment
  listOfBul;  % list of bullets
  range;      % effective range of bullet
  Xs;         % absolute x coordintes in the plot
  Ys;         % absolute y coordintes in the plot
  dia = 7;    % size of the bullet, only used in `scatter()`
  color = 'w';     % color of the bullets
Other variables:
  newBullet   % bullet instance
  outdates    %bullets that should be deleted
```


`tank.m`
```matlab
Property variables:
  mLength = 32; % the pixel mLength of the tank image
  oriValue;    % records the original image
  value;       % image used in the plot
  upValue;     % image of tank facing up
  downValue;   % image of tank facing down
  leftValue;   % image of tank facing keft
  rightValue;  % image of tank facing right
  bg;          % background, or to say the environment
  opponent;    % reference opponent more easily 

  lifes;       % just... lifes
  HPpool = 3;  % max hit could afford
  health;      % current health
  dir;         % facing direction

  fire = 0;    % whether player press the key to fire
  fireCD = 6;  % time interval between each shot
  countDown = 0;   % CD from last attack
  shells;      % alias of `bullets`

  birthX;      % relative x coordintes of tanks' birth place
  birthY;      % relative y coordintes of tanks' birth place
  inMapX;      % absolute x coordintes in the plot
  inMapY;      % absolute y coordintes in the plot
  x;           % relative x coordintes in the plot
  y;           % relative y coordintes in the plot

  gotHitFX;    % sound effect for getting hit
  shootFX;     % sound effect for shooting
  dieFX;       % sound effect for death
Other variables:
  newBullet    % bullet instance
  res          % result recording whether opponent is ahead 
  moveUpWeight     % decision weight for moving up
  moveDownWeight   % decision weight for moving down
  moveLeftWeight   % decision weight for moving left
  moveRightWeight  % decision weight for moving right
```


'tankgame.m'
```matlab
  game        % global class of the game
  bg          % global instance of class background 
  p1          % gloabl instance of class tank
  p2          % gloabl instance of class tank
  game.on = true;                  % whether the gameis on
  game.showHelp = 0;               % show help if true
  game.botMatch = 0;               % place holder for bot status
  game.instractorMode = 0;         % E rated content if `true`
  game.firstBloodTaken = 0;        % avoid multi-firstblood
  game.UI                          % the figure
  game.lastWinner = "null";        % for recording kill streak
  game.p1Streak = 0;               % kill streak of p1
  game.p2Streak = 0;               % kill streak of p2
  game.totalKill = 0;              % total kill in the game
  game.firstBlood                  % image for first blood
  game.doubleKill                  % image for double kill
  game.dominating                  % image for dominating
  game.firstBloodSound             % sound for first blood
  game.doubleKillSound             % sound for double kill
  game.dominatingSound             % sound for dominating
  game.ending.index = 0;           % selection index in ending screen
  game.ending.in = 0;              % whether user makes the decision
  game.pause.pauseImg              % image for pause screen
  game.pause.decided = 0;          % whether user makes the decision
  game.pause.index = 0;            % selection index in pause screen
  game.pause.in = 0;               % whether it's still pause
  game.offsetX                     % array recording text x loction in scoreBoard
  game.offsetY                     % scaler recording text y loction in scoreBoard
  game.loading.bgImg               % image for loading screen
  game.loading.selImg              % the slection icon image
  game.loading.undecided = 1;      % looping condition 
  game.loading.index = 0;          % records user choice 
  game.loading.selectX = 4;        % x coordinate of arrow icon
  game.loading.selectY = 7;        % y coordinate of arrow icon
  p1StreakImg                      % image for player one's killing streak
  p2StreakImg                      % image for player two's killing streak\
  game.ending.in = 1;      % looping condition    
  game.ending.decided = 0; % if the user hit enter
```

