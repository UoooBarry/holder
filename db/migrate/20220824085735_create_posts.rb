class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true
      t.references :post, null: true
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
