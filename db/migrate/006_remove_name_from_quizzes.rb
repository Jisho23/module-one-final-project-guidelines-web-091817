class RemoveNameFromQuizzes < ActiveRecord::Migration[4.2]
  def change
    remove_column :quizzes, :name
  end
end
