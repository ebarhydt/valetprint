class AddCopiesToItems < ActiveRecord::Migration
  def change
    add_column :items, :copies, :integer
  end
end
