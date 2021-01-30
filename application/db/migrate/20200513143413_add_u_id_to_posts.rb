class AddUIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :uID, :integer
  end
end
