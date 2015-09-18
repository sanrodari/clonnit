class AddDefaultToSubclonnit < ActiveRecord::Migration
  def change
    add_column :subclonnits, :default, :boolean
  end
end
