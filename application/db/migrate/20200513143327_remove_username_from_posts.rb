class RemoveUsernameFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :username, :string
  end
end
