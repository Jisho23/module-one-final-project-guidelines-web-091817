class CreateQuestions < ActiveRecord::Migration[4.2]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :content #Not sure if necessary
      t.integer :quiz_id
      t.integer :answer_id
    end
  end
end
