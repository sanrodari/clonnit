class AddUsernameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :username, null: false
      t.index :username, unique: true
    end
  end
end
