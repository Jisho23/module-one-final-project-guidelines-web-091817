Game Mechanics

Our Trivia Game is amazing fun! The layout is fairly self-explanatory, but we'll give a run-down anyways.

To start the game, run 'ruby bin/run.rb'. Look!  A fun little welcome message! The game pauses after 'What's your name?' and waits for you to enter your name.

CREATE USERNAME
The first step is to create a username. We recommend your name, but it is case-sensitive ('Santa' isn't the same as 'santa').
If you already have a username, just type that in, and it will find you! If, for some reason, you need to delete a username, enter '3.14159' instead, and
it will let you delete a username by entering the username to be removed (remember, be specific, and careful here. Deleted users are gone forever).

STARTING THE GAME
Once you select or create a new user, its on to the game!
'What do you want to do?'. Here, you have 5 options: play a new game, check statistics, change your user, check leaderboard, and exit. We'll take those one at a time.
'PLAYGAMEPLAYGAMEPLAYGAME': Starts a new game of TRIVIA! Go to 'GAMEPLAY' section below.
'Check Stats': Checks your personal stats for all game this username has played
  -There are 3 new options: All time average, statistics by difficulty, and Back to start. All time average shows how many questions you've correctly answered out of how many total, statistics divided amongst each difficulty level, and Back to start takes you back to PLAYING THE GAME. If you haven't played any games, you'll get a little message telling you that.
'Change User': Brings you back to CREATE USERNAME
'Check Leaderboard': Displays all users' correctly answered question tally and percentages! Beat your friends!
'Exit': You don't want to play anymore :( This will exit you out of the game. Come back soon!

GAMEPLAY
Once you select PLAYGAMEPLAYGAMEPLAYGAME, you get a totally unbiased and modest statement of the quality of our game. Now you need to choose your difficulty. Easy, Medium, Hard, or Exit. These will set the difficulty of the questions for the TRIVIA GAME, or exit the game.
Next, choose how many questions you'd like to have in your TRIVIA GAME!
A new quiz will be created based on your inputs.

The questions will show up in pink, with the answers below.  Just enter the number corresponding number to select that answer. Play until you reach the end! (Incorrect answers will... you'll find out :D).

Don't worry! When you get a question wrong, it will tell you what the correct answer is.

Once you finish a game, your score for that game of TRIVIA will show up, and bring you back to STARTING THE GAME. Play another game, or check out your stats!

Thanks for playing!

Hint: There are easter eggs scattered throughout.

#---------------------------------
Detailed method descriptions
Methods are explained in order, by file. Select and search for a method name to see what it does, and what it calls.

lib/adapter.rb
  -URL, a constant, stores most of the API url which is completed in the self.quiz_api which passes the difficulty as an argument. The competed URL is then scraped for data with RestClient, and parsed into useable data with JSON. The resulting array, containing a hash, is run through an iteration to extract the data. Some data are inside additional arrays, which is where the if value.is_a? Array runs them through another iteration, and all values are passed into the delete_quotes method to remove weird symbols and mis-translated quotation marks (&quot;, for example).

lib/cli.rb
  -welcome:
    Outputs a welcome message, runs the pick_user method.
  -start_game
    Main game flow method, runs through methods necessary to pick_difficulty and pick_number_of_questions from the user, make and take the trivia game (make_quiz, take_quiz), determine score at the end (did_you_win), and brings you back to the main menu afterwards (choose_next_steps). This is called mostly by instance methods locally (through the CLI). The instance variable 'number of questions' is for ease of use in later methods.
  -pick_user
    Allows you to find, create, and delete users from the database. The gameflow requires an input of 3.14159 to delete a user, otherwise a new user is created or found by their name. The helper method 'query user' is for ease of repetitive use (as opposed to repetitive 'gets.chomp'). Upon completion, moves user to the main menu method 'choose_next_steps'
  -delete_user
    If 3.14159 was entered above, this method runs, and takes input of a name, finds that name's unique ActiveRecord id, and removes it from the database by that id. Names not found in the database will return an error message. Upon completion, automatically moves user to pick_user method.
  -pick_difficulty
    Takes user input and assigns a string based on that input. This is passed into adapter.rb, quiz.api to complete the URL. An Easter egg is here :D This is used as a parameter in make_quiz.
  -pick_number_of_questions
    take user input, checks to see if that input is a number between 1 and 20 and outputs an error message if not. This is used as a parameter in make_quiz.
  -make_quiz
    Take in parameters of difficulty and number_of_questions, sets a @new_quiz instance variable equal to a new instance of Quiz, and sets the user_id equal to the current instance of User (chosen in pick_user, has a unique id) and difficulty to the passed in difficulty string.
    The new_quiz then calls on create_questions_by_integer, passing in number_of_questions, to create that many questions, and each newly created question is given the user_id equal to the current instance of the user.id followed by a save on that question instance. The quiz is then saved to the database after this.
  -take_quiz
    The just created @new_quiz's questions are iterated through, and each question's answers are displayed with display_answers. User input is taken for which answer they want, and those answers have their user_id attribute set to the current instance of user.id. All the answers to this question also have their quiz_id attribute set to the current instance of user.id, and are then saved. This allows for easy searching through user or through quiz (for questions and answer) and visa versa.
  -question_input_valid
    This checks to make sure the user input for choosing an answer is a valid option (before it gets passed to stamp_answer_with_user_id inside take_quiz)
  -choose_next_steps
    This is effectively the main menu of the gamer. Takes user input and selects the appropriate method to call based on that input. There are a few easter eggs. Can call start_game, user_stats, pick_user.
  -user_stats
    Takes user input for which stat to see. when "1" checks for total_average >= 0, because a -1 will be passed in from calculate_average if a denominator would be equal to 0 (math breaks in that case).
  -did_you_win
    This finds the array of all correct answers (set in question.rb create_correct_answer where their truthiness is set to true, create_incorrect_answers sets wrong answers to false), and gets the length of correct_answers and number_of_questions, and calls Table.display_quiz_score with that data. Special images are displayed if you got 100%, or 0% right. It then calls winning?
  -winning?
    This puts a simple statement of all time correct_answers.count, the count of all answered questions (Answer.all.where(user_id: user.id).size), and calculates a percentage using total_average.
  -difficulty_stats
    This takes in a parameter of difficulty (set in pick_difficulty), finds all the quizzes with that difficulty, answered by the current user (quizzes_by_difficulty). In user_stats, it is called 3 times, so is run through for each quiz difficulty (easy, medium, hard), and calculates an average for each quiz difficulty, and displays that. If quizzes_by_difficulty.length is 0 (no quizzes of that difficulty have been played), it skips Table creation and outputs a message. Otherwise, a Table is made with 'display_average_by_difficulty, passing in difficulty, and final_average, and the average of correct answers for that difficulty.

lib/clreporter.rb
  This is where Table's are made.
  -self.display_text_box
    takes in an argument of text, and makes a single cell table with that text, of the length of that text. This is called on questions to be displayed (they're varying lengths)
  -self.display_quiz_score
    This takes in correct_answers and number_of_questions, and displays a table with that data and column headings of 'Correct Answers', and "Number Of Questions." This is called in did_you_win.
  -self.display_average_by_difficulty
    Takes in difficulty and average, and is used in difficulty_stats to output tables with the average percentage of questions answered correctly, and their associated difficulty.
  -self.leader_board_table
    This makes a table with columns User, Correct Answers, and Average, and is used in User_stats.leader_board.empty? to create the leaderboard table.

lib/helper_methods.rb
  These are a few methods that kept getting called, so were abstracted out.
  -self.query_user
    gets.strip was used instead of gets.chomp to deal with whitespace (inputs of '1     ' were breaking code). An until loop is used to deal with empty inputs, and ensure a valid input is entered.
  -self.check_for_zero?
    This checks to make sure a value is 0, to be called in methods where a denominator being 0 would break the code.
  -self.create_space
    Whenever we need a new line to make the output more readable.

lib/user_stats.rb
  -self.leaderboard
    This iterates through all users, checking that they've taken more than 0 quizzes, and adds those who have to a leaderboard array. If that leaderboard array isn't empty, it will be sorted by percentage of total questions answered correctly.  A Table is then made, with this sorted array, reversed, so the highest percentage is put first. Makes a high scores table.

app/models/answer.rb
  -right_or_wrong
    This checks if an answer was true of not. It is used within Question stamp_answer_with_user_id, and displays either a correct message, or an 'incorrect' image.

app/models/question.rb
  -create_answers
    Takes in an argument of a question_hash (generated in Quiz.rb), and iterates through the hash, calling create_correct_answer or create_incorrect_answers depending on the hash value.
  -display_answers
    This is called from take_quiz, and shuffles the answer order around before assigning each a number_identifer (to be used to determine which answer a user chooses, because the shuffling is random)
  -create_correct_answer
    This creates an answer, and sets its attributes. Truthiness is set to true.
  -create_incorrect_answers
    Just like above, except truthiness is set to false. Incorrect_answers are inside an array in the scraped data from the api.
  -get_users_answer
    This method is used to accept user input for choosing an answer to questions, and checks (with valid_answer?) that the input is between 1 and 4.
  -valid_answer?
    this makes sure that the users answer input isn't something other than 1, 2, 3, or 4.
  -stamp_answer_with_user_id
    This takes in a user answer, and the current user_id, and sets the answer.user_id attribute equal to the id of the user who answered the question (for use in data collection to link user and answers by that user). If the answer is wrong, it outputs the correct answer with show_right_answer
  -show_right_answer
    Finds the correct answer from this questions' (self) answers, by its truthiness value, and outputs it's content.

app/models/quiz.rb
  -create_question
    This method generates a question hash by calling on the Adapter.quiz_api method, passing in the chosen difficulty. It then makes a new Question, and sets its attributes.
  -create_questions_by_integer
    Calls on create_question the number of times number_of_questions equals.


app/models/user.rb
  -correct_answers
    gets all the questions answered correctly for this current user instance.
  -correct_answers_by_quiz
    takes correct_answers and an input of a quiz, and selects for just the answers where the quiz.id is equal to the answer_id
  -total_average
    gets the length of the correct_answers array, and the length of all answers for this current user. calls on calculate_average to get the average.
  -average_by_quiz
    takes an input of a quiz, and calls on calculate_average with correct_answers_by_quiz, and the amount of questions in the given quiz to get the number of correct per quiz.
  -calculate_average
    Thisb take in two parameters, a set of correct_answers, and total_answers. It checks that total_answers isnt 0, and outputs an error message in that case, and returns -1 instead of 0. Otherwise, it calculates an average. This is used in average_by_quiz and total_average to get percentages of correctly answered questions.
