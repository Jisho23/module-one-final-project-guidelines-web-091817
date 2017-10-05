class AddQuizIdToAnswers < ActiveRecord::Migration[4.2]
  def change
    add_column :answers, :quiz_id, :integer
  end
end
