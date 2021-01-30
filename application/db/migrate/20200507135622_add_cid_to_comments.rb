class AddCidToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :cID, :integer
  end
end
