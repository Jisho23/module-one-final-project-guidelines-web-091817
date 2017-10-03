class AddDifficultyToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :difficulty, :strings
  end
end
