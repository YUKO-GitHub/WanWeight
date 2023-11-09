class AddNotNullToUserWeights < ActiveRecord::Migration[7.0]
  def change
    change_column_null :user_weights, :weight, false
    change_column_null :user_weights, :date, false
  end
end
