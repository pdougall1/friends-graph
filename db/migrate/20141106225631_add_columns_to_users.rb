class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_id, :string
    add_column :users, :industry, :string
    add_column :users, :distance, :integer
    add_column :users, :num_connections, :integer
    add_column :users, :picture_url, :string
    add_column :users, :email, :string
  end
end
