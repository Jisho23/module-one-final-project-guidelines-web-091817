<<<<<<< HEAD
class CreateQuotes < ActiveRecord::Migration[4.2]
=======
class CreateQuotes < ActiveRecord::Migration
>>>>>>> 5485a82367eeca3fc691c4cbbd69b398b44fbae7
  def change
    create_table :quotes do |t|
      t.string :content
    end
  end
end
