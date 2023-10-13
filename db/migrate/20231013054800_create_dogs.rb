class CreateDogs < ActiveRecord::Migration[7.0]
  def change
    create_table :dogs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :birthday
      t.integer :sex
      t.string :breed
      t.string :profile_image

      t.timestamps
    end
  end
end
