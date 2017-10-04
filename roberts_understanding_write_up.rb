To start the game, we run ruby bin/run.rb, which runs the welcome
method in lib/cli.rb.

The welcome method puts out a few statements, then calls start_game.
start game first sets an instance variable, @user to the method
pick_user. pick_user puts out a few statements, gives an option to delete
users, and accepts input. Based on the input, a user is either found
from the database (users table), created, or we move into the delete_user
method.

The delete_user method accepts input of a name, gets the user id of
that name, and deletes from the users table that object with that
primary key, then calls the pick_user method again.

Back in the pick user method, assuming they make or find a user, we move on
to creating a quiz.  A variable of difficulty is set equal to the pick_difficulty
method, which accepts input, and returns the corresponding string to use in the
trivia api to get that difficulties questions. Its all inside a while loop,
and incorrect questions display an error message, until a correct input is achieved.

Back to start_game, we move on to picking how many questions. An instance variable
@number_of_questions (for later use in stats work) is set equal to pick_number_of_questions
which accepts input of how many questions tey want. It checks that the number of questions is between
1-20 (arbitrary), outputs an error message if any other input is received, and c alls itself until a correct input is entered.
returns that many questions as integer.

Back to the start_game method. Output a confirmation sentence of difficulty and
number of questions, then we make_quiz with those parameters.

make_quiz accepts difficulty and number_of_questions, and makes a new instance
of Quiz, and sets the column data for its necessary columns. user_id (the user selected earlier), difficulty,
and thenits saved, and we make questions depending on how many
questions were entered. create_questions_by_integer (inside quiz.rb) calls on the create_question,
gnerates a hash of question data from the api (based on that difficulty), and mkes a new
question, then sets column data for the question. create_answers (inside question,.rb) is called inside this method,
on the instance of Question just made, and creates answers to be displayed. The
answers inside the question hash have a key of correct_answer or incorrect answer, and depending on which one,
are sent to create_correct_answer or create_incorrect_answers, and their truthiness column data is set accordingly, along with content (from passed in question hash),
and question_id (set to the instance of the question).

back to cli, the newly made questions (with id equal to the question_id they belong to) have their user_id set to the user taking the current quiz.

back up to start_game, we move on to take_quiz.

In take_quiz, @new_quiz (made in make_quiz, has questions linked by question.quiz_id == quiz.id) and answers for those
questions, answer.question_id == question.id). puts out the question content, then calls display_answers
on the question. display_answers shuffles the array of answers, and assigns a number_identifier to them equal to where
they are in the display order. We then get user input, by number, for which question they want, and the
question.user_id is set equal to the user.id. The answers are then all given a quiz_id equal to the quiz.id
