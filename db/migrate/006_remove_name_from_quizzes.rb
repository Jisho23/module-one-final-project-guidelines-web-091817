class RemoveNameFromQuizzes < ActiveRecord::Migration
  def change
    remove_column :quizzes, :name
  end
end
