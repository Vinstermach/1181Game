# ENGR 1181 Game Project Collab

Matlab code for game

# Formatting Suggestions

* __Lower camel case variable names__

  Name the variable `nameOfVariable` instead of `NAMEOFVARIABLE`, `nameofvariable` or `name_of_variable`

* __Space between operators__

  Use `var = num;` instead of `var=num;`
  
* __Indet scopes__

  Indent like this:
  
  ```matlab
  function output = foo(para)
    % comment
    var = experssion;
    while(booleanValue) 
      statement;
      if(booleanValue) 
        statement;
        var = experssion;
        ...
      end
    end
  end
  ```
  Not like this:
  ```matlab
  function output = foo(para)
  % comment
  var = experssion;
  while(booleanValue) 
  statement;            %That sucks
  if(booleanValue) 
  statement;
  var = experssion;
  ...
  end % who the fuck knows which branch/loop that end corresponds to? 
  end
  end
  ```
  
  This also applies to XML and CSS (if we use that).
  
* __Folding__

  No folding style is required. However, suggesting fold the loop/branch into one single line when it is very short.
  
  For example, instead of 
  ```matlab
  ...
  if (booleanValue)
    var = 1;
  end
  ```
  
  You can simply do 
  ```matlab
  ...
  if (booleanValue) var = 1; end
  ```

* __Rational naming and comment whenever necessary__

  Try to name the variable/function/parameter/attribute in a self explanatory manner. For example, name the attribute of obeject `game` that carrys the number of enemy currently in the screen as `game.enemyInScreen` instead of some random shit like `game.ie`. Never use a single character non-related to the variable itself like `a`, `b`, `c` as name, __NEVER, EVER, EVER, EVER, EVER__.
  
  If the name is not quite self explanatory, add comment explaining what this variable/function/parameter/attribute is about. For example: 
  ```matlab
  function pic2ary(path)
    % read a picture and convert it to a 3d array
    implementation...
  ```

# Using git to commit changes 

If you're only working on one single file and no one else is working on that, it's okay to use GitHub web version to commit. But if you are collabrating with others on the same file, or modified multiple files, using web version would be a real pain. Thus I really recommand using Git. You can download Git [here](https://git-scm.com/downloads). 

Note that GitHub is a platform that holds the code, while Git is the core that does the version/source control job. 

* __Get started__

  Set the folder you want to work in. you can simply open that folder in resource explorer (Windows) and right click `select Git Bash Here`. Or if you want to experience that pure Linux feeling, open Git command line and use `cd` command to move to the destination folder. 
  
  Then open git bash command line, type `git clone URL` (Substitute `URL` with repo URL). This will download the repo to your local device. 
  
* __Upload__
  
  Type `git add FILENAME`, substitute `FILENAME` with the file name. 
  
  Type `git commit`. If you want to add message then type `git commit -m'MESSAGE'`.
  
  Type `git push` to push into master branch.
  
* __Sync__ 

  Type `git pull` to sync the local repo with the one on GitHub.
  
  Note that `push` is upload local file to GitHub, `pull` is download GitHub file to local. Both will preserve unchanged file, only modificed part will be updated.  

# Current goal in general 

1. Develop in game purchases system;
2. Develop the main website of the game, in which the purchases will be processed (and redirected);
3. Documentation, flowchart etc.;


