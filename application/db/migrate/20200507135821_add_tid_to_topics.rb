class AddTidToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :tID, :integer
  end
end
