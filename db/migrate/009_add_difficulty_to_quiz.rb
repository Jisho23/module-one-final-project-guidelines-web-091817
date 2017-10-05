class AddDifficultyToQuiz < ActiveRecord::Migration[4.2]
  def change
    add_column :quizzes, :difficulty, :string
  end
end
