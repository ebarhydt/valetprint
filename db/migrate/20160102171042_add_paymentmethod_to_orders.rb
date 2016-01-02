class AddPaymentmethodToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :paymentmethod, :string
  end
end
