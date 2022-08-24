class AddCreatorIdToCommunity < ActiveRecord::Migration[6.1]
  def change
    add_column :communities, :creator_id, :bigint

    add_index :communities, :name, unique: true
  end
end
