class AddLargePictureUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :large_picture_url, :string
  end
end
