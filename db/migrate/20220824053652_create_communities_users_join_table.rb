class CreateCommunitiesUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :communities_users do |t|
      t.references :user
      t.references :community

      t.timestamps
    end

    add_index :communities_users, %i[community_id user_id], unique: true
  end
end
