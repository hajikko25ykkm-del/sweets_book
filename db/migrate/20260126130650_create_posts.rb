class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body
      t.integer :user_id, null: false
      t.boolean :is_private, default: false, null: false
      
      t.timestamps
    end
  end
end
