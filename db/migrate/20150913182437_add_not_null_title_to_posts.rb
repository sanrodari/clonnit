class AddNotNullTitleToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.change :title, :string, null: false
    end
  end
end
