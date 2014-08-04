class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.integer :post_id, null: false
    end

    add_index :links, [:url, :post_id], unique: true
  end
end
