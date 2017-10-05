class CreateAnswers < ActiveRecord::Migration[4.2]
  def change
    create_table :answers do |t|
      t.string :content
      t.integer :question_id
      t.integer :user_id
      t.boolean :truthiness
    end
  end
end
