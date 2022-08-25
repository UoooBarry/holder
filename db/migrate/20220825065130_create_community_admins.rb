class CreateCommunityAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :community_admins do |t|
      t.references :community, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
