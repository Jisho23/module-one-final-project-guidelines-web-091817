class RemoveAnswerIdAndNameFromQuizzes < ActiveRecord::Migration[4.2]
  def change
    remove_column :quizzes, :name
    remove_column :quizzes, :answer_id
  end
end
