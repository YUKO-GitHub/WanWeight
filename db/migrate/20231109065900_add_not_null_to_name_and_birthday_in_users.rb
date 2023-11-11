class AddNotNullToNameAndBirthdayInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :birthday, false
  end
end
