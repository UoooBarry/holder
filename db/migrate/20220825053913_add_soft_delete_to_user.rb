class AddSoftDeleteToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_deleted, :boolean, default: false, null: false, index: true
  end
end
