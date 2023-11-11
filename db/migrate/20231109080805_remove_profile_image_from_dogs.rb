class RemoveProfileImageFromDogs < ActiveRecord::Migration[7.0]
  def change
    remove_column :dogs, :profile_image, :string
  end
end
