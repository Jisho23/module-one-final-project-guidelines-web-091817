class AddQuizIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :quiz_id, :integer
  end
end
