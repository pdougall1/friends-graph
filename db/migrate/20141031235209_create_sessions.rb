class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :access_token
      t.string :facebook_id
      t.datetime :expiration

      t.timestamps
    end
  end
end
