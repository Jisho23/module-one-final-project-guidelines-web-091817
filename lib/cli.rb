require 'pry'
class CLI
  attr_accessor :new_quiz, :user

  def welcome
    puts "Welcome to TRIVIA!"
    puts "ARE"
    puts "   YOU"
    puts "      WORTHY?"
    start_game
  end

  def start_game
    @user = pick_user
    puts "Our trivia game is basically the best thing ever. Ever"
    difficulty = pick_difficulty
    number_of_questions = pick_number_of_questions
    puts "Awesome! You chose difficulty #{difficulty}, with #{number_of_questions} questions."
    make_quiz(number_of_questions)
  end

  def pick_user
    puts "Let's find your records, or make a new username for you."
    puts "What's your name?"
    input = gets.chomp
    find_or_create_by(input)
  end

  def find_or_create_by(name)
    User.find_or_create_by(name: name)
  end

  def pick_difficulty
    puts "Please choose your difficulty: 1. Easy. 2. Medium. 3. Hard. 4. Exit"
    difficulty_level = gets.chomp
    case difficulty_level
    when "1"
      "Easy"
    when "2"
      "Medium"
    when "3"
      "Hard"
    when "Easter Egg"
      puts "ASAMBI SANA SQUASH BANANA"
      pick_difficulty
    when "4"
      exit
    else
      puts "Hmm, that isn't an option, pick again"
      pick_difficulty
    end
  end

  def pick_number_of_questions
    puts "How many questions would you like? (Enter a number, 1-20)"
    number_of_questions = gets.chomp
  end


  def make_quiz(number_of_questions)
    @new_quiz = Quiz.create
    binding.pry
    new_quiz.user_id = @user.id
    #how to add difficulty is on joshs branch
    new_quiz.create_questions_by_integer(number_of_questions.to_i)
    take_quiz
  end

  def take_quiz

  end

  #-------- post-game stats
  def winning?
    #output how many questions you got right, and how many total questions there were
  end

  def user_stats
    #things like overall percentage, by quiz (>75%, say), and by question number. multiple methods, probably

  end



end


# #flow of the game:
# select user.  find_or_create_by to select from existing user or make a new one and add to table
# user selects difficulty and number of questions
# pull quiz with those criteria from db (with adapter)
# drop_user_by_name method?

# display_questions will show all questions
