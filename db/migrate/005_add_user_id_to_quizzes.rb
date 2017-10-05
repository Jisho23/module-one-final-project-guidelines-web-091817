class AddUserIdToQuizzes <ActiveRecord::Migration[4.2]
  def change
    add_column :quizzes, :user_id, :integer
  end
end
