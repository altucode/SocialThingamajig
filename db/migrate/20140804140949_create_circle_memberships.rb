class CreateCircleMemberships < ActiveRecord::Migration
  def change
    create_table :circle_memberships do |t|
      t.integer :user_id
      t.integer :circle_id
      t.date :created_at
    end

    add_index :circle_memberships, [:user_id, :circle_id], unique: true
  end
end
