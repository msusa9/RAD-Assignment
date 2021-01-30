class AddViewsToTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :views, :integer
  end
end
