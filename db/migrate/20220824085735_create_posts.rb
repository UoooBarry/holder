class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true
      t.references :post, null: true
      t.string :title, null: false
      t.text :content, null: false
      t.integer :status, null: false, default: 0, index: true
      t.boolean :pin, null: false, default: false

      t.timestamps
    end
  end
end
