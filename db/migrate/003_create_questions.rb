class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content #text displayed for cli
      t.integer :quiz_id #quiz it belongs to
    end
  end
end
