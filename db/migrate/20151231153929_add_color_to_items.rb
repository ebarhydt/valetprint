class AddColorToItems < ActiveRecord::Migration
  def change
    add_column :items, :color, :boolean
  end
end
