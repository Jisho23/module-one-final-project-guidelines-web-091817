<<<<<<< HEAD
class CreateQuestions < ActiveRecord::Migration[4.2]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :content #Not sure if necessary
      t.integer :quiz_id
      t.integer :answer_id
=======
class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content #text displayed for cli
      t.integer :quiz_id #quiz it belongs to
>>>>>>> master
    end
  end
end
