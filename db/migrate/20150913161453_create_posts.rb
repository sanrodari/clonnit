class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :text
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :subclonnit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
