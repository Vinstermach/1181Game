# ENGR 1181 Game Project Collab

Matlab code for game

# Formatting Suggestions

* __Small camerl case variable names__

  Name the varible `nameOfVarable` instead of `NAMEOFVARIABLE` or `nameofvariable`

* __Space between operators__

  Use `var = num;` instead of `var=num;`
  
* __Indet scopes__

  Indent like this:
  
  ```matlab
  var = experssion;
  while(booleanValue) 
    statement;
    if(booleanValue) 
      statement;
      ...
    end
  end
  ```
  Not like this:
    ```matlab
  var = experssion;
  while(booleanValue)  %That sucks
  statement;
  if(booleanValue) 
  statement;
  ...
  end % who the fuck knows which branch/loop that end corresponds to? 
  end
  ```
