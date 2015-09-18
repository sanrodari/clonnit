class AddUniqueIndexToSubclonnitName < ActiveRecord::Migration
  def change
    change_table :subclonnits do |t|
      t.change :name, :string, null: false
      t.index :name, unique: true
    end
  end
end
