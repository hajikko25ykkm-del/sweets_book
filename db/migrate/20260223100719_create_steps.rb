class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.references :post, null: false, foreign_key: true
      t.text :content, null: false, limit: 1000
      t.integer :position

      t.timestamps
    end
  end
end
