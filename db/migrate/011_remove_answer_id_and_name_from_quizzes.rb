class RemoveAnswerIdAndNameFromQuizzes < ActiveRecord::Migration
  def change
    remove_column :quizzes, :name
    remove_column :quizzes, :answer_id
  end
end
