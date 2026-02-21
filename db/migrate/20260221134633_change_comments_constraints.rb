class ChangeCommentsConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :body, :text, limit: 1000, null: false

    add_column :comments, :parent_id, :integer
    add_index :comments, :parent_id
  end
end
