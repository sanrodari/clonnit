class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.belongs_to :post, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
