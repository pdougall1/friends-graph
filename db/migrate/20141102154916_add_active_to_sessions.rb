class AddActiveToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :active, :boolean
  end
end
