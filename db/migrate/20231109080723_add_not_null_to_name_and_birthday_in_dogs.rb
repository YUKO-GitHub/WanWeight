class AddNotNullToNameAndBirthdayInDogs < ActiveRecord::Migration[7.0]
  def change
    change_column :dogs, :name, :string, null: false
    change_column :dogs, :birthday, :date, null: false
  end
end
