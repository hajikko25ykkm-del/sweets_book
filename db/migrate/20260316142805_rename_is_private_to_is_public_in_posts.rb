class RenameIsPrivateToIsPublicInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :is_private, :is_public
  end
end
