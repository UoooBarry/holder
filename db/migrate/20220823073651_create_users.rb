class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :email, null: false
      t.integer :gender, default: 0
      t.integer :age
      t.text :bio

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
