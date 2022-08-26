class AddUniqIndexToACommunityAdmin < ActiveRecord::Migration[6.1]
  def change
    add_index :community_admins, %i[user_id community_id], unique: true
  end
end
