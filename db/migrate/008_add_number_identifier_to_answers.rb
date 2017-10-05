class AddNumberIdentifierToAnswers < ActiveRecord::Migration[4.2]
  def change
    add_column :answers, :number_identifier, :integer
  end
end
