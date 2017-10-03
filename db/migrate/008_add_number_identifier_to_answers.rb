class AddNumberIdentifierToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :number_identifier, :integer
  end
end
