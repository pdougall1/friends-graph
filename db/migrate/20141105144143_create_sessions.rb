class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :access_token
      t.datetime :expiration
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
