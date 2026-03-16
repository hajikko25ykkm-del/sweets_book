class ChangeDefaultIsPublicInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :is_public, from: false, to: true
  end
end
