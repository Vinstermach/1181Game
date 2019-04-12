clc
clear

fprintf('Opening text')
charList = convert(wordbank) %convert string to characters
wordList = textscan(wordbank)%scans words for a word
chosen = C(wordlist)
wordLength  = strlength(chosen) 

%loop for replacing letters with ?
while i <= wordLength
    answer(i) = '?';
    i = i + 1;
end

fprintf('The word chosen is: ');
fprintf(answer);
numberleft = length(find(answer=='?'));
fprintf('\nThis word has %.0f characters in it',numberleft);
fprintf('\n')
strJava = java.lang.String(chosen); % convert to java string

numberOfGuesses = 1;
prevguess = "";
guess = "";

%sets each guess amount to nothing

%while loop for guessing the letters with checks on input
while numberOfGuesses <=7
    Wrong = 1;
    if numberOfGuesses <=7
        prevguess = guess;
        %stores each guess as previous guess to check that user is not
        %double selecting letters and getting a guess taken off for it
       prompt = ('\nGuess a letter!: ');
        guess = input(prompt,'s');
       for j=1:wordLength
            if chosen(j) == guess
                answer(j) = guess;
                disp(answer);
                count(answer,'?');
                numberleft = length(find(answer=='?'));
                Wrong = 0;
            elseif prevguess == guess
                fprintf('Invalid answer, please try again!')
                prompt = ('\nGuess a letter!: ');
                guess = input(prompt,'s');      
            end
       end

%if statements for each guess that outputs the Hangman Character

       if numberOfGuesses == 1 && chosen(j) ~= guess && Wrong ~=0
            fprintf('Sorry %s is not in the mystery word',guess)
            guessesleft = 7 - numberOfGuesses;
            fprintf('\nYou have %.0f guesses left\n',guessesleft);
            fprintf("\n   ");
            fprintf("\n   ");
            fprintf("\n   ");
            fprintf("\n   ");
            fprintf("\n   ");
            fprintf("\n   ");
            fprintf("\n   ");
            fprintf("\n___|___");
            numberOfGuesses = numberOfGuesses + 1;
        elseif numberOfGuesses == 2 && chosen(j) ~= guess && Wrong ~=0
            fprintf('Sorry %s is not in the mystery word',guess)
            guessesleft = 7 - numberOfGuesses;
            fprintf('\nYou have %.0f guesses left\n',guessesleft);
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n___|___");
            numberOfGuesses = numberOfGuesses + 1;
        elseif  numberOfGuesses == 3 && chosen(j) ~= guess && Wrong ~=0
            fprintf('Sorry %s is not in the mystery word',guess)
            guessesleft = 7 - numberOfGuesses;
            fprintf('\nYou have %.0f guesses left\n',guessesleft);
            fprintf("\n    ______________");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n   |");
            fprintf("\n___|___");
            numberOfGuesses = numberOfGuesses + 1;
        elseif  numberOfGuesses == 4 && chosen(j) ~= guess && Wrong ~=0
            fprintf('Sorry %s is not in the mystery word',guess)
            guessesleft = 7 - numberOfGuesses;
            fprintf('\nYou have %.0f guesses left\n',guessesleft);
                fprintf("\n    ______________");
           	fprintf("\n   |          _|_");
           	fprintf("\n   |         /   \\");
           	fprintf("\n   |        |     |");
           	fprintf("\n   |         \\_ _/");
           	fprintf("\n   |");
           	fprintf("\n   |");
           	fprintf("\n   |");
           	fprintf("\n___|___");
            numberOfGuesses = numberOfGuesses + 1;
        elseif  numberOfGuesses == 5 && chosen(j) ~= guess && Wrong ~=0
            fprintf('Sorry %s is not in the mystery word',guess)
            guessesleft = 7 - numberOfGuesses;
            fprintf('\nYou have %.0f guesses left\n',guessesleft);
            fprintf("\n    ______________");
           	fprintf("\n   |          _|_");
           	fprintf("\n   |         /   \\");
           	fprintf("\n   |        |     |");
           	fprintf("\n   |         \\_ _/");
           	fprintf("\n   |           |");
           	fprintf("\n   |           |");
           	fprintf("\n   |");
           	fprintf("\n___|___");
            numberOfGuesses = numberOfGuesses + 1;
        elseif  numberOfGuesses == 6 && chosen(j) ~= guess && Wrong ~=0
            fprintf('Sorry %s is not in the mystery word',guess)
            guessesleft = 7 - numberOfGuesses;
            fprintf('\nYou have %.0f guess left\n',guessesleft);
            fprintf("\n    ______________");
            fprintf("\n   |          _|_");
           	fprintf("\n   |         /   \\");
           	fprintf("\n   |        |     |");
           	fprintf("\n   |         \\_ _/");
           	fprintf("\n   |           |");
           	fprintf("\n   |           |");
                fprintf("\n   |          / \\ ");
           	fprintf("\n___|___      /   \\");
            numberOfGuesses = numberOfGuesses + 1;
        elseif  numberOfGuesses == 7 && chosen(j) ~= guess && Wrong ~=0
            fprintf('Sorry %s is not in the mystery word',guess)
            fprintf("\n    ______________");
            fprintf("\n   |          _|_");
           	fprintf("\n   |         /   \\");
           	fprintf("\n   |        |     |");
           	fprintf("\n   |         \\_ _/");
           	fprintf("\n   |         / | \\");
           	fprintf("\n   |           |");
                fprintf("\n   |          / \\ ");
           	fprintf("\n___|___      /   \\");
            fprintf('\n You lose');
            numberOfGuesses = 8;
            fprintf('\nThe word was: %s!',chosen)
            str = "";
            while str ~= "yes" || str ~= "no"
                prompt = ('\nPlay Again? [yes, no] ');
                str = input(prompt,'s');
                
                if str == "yes"
                    run('HangmanGame.m')
                    
                elseif str == "no"
                    fprintf('Thanks for playing!!!')
                    return
                end
            end
        end
        if answer == chosen
            fprintf('\nYou won! The Hangman has been cheated of his day!');
            numberOfGuesses = 8;
            fprintf('\nThe word was: %s!',chosen)
            str = "";
            if str ~= "yes" || str ~= "no"
                prompt = ('\nPlay Again? [yes, no] ');
                str = input(prompt,'s');
            elseif str == "yes"
                run('HangmanGame.m')
            elseif str =="no"
                fprintf('Thanks for playing!!!')
                return; %this return function would start the game over
            end
        end
    end
end
