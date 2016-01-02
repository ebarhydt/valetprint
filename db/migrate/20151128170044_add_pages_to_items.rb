class AddPagesToItems < ActiveRecord::Migration
  def change
    add_column :items, :pages, :integer
  end
end
