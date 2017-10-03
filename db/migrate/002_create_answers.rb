<<<<<<< HEAD
class CreateAnswers < ActiveRecord::Migration[4.2]
=======
class CreateAnswers < ActiveRecord::Migration
>>>>>>> master
  def change
    create_table :answers do |t|
      t.string :content
      t.integer :question_id
      t.integer :user_id
<<<<<<< HEAD
=======
      t.boolean :truthiness
>>>>>>> master
    end
  end
end
