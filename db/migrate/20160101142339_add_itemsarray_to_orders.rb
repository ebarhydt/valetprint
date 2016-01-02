class AddItemsarrayToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :itemsarray, :text
  end
end
