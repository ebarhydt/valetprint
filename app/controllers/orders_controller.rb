class OrdersController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    1.times { @order.items.build }
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @order.itemsarray.each do |item_id|
        @item = Item.find(item_id)
        @order.items << @item
      end
      OrderMailer.order_request(@order).deliver_later
      OrderMailer.order_confirmation(@order).deliver_later
      # flash[:success] = 'File upload worked'
      render json: @order
    else
      # flash[:danger] = "File upload didn't work"
      render json: @order.errors, status: :unprocessable_entity
    end
  end


  private
    def order_params
      params.require(:order).permit(
        :id, 
        :address,
        :name,
        :email,
        :phone,
        :address2,
        {:itemsarray => []},
        :zipcode,
        :paymentmethod,
        :items_attributes => [:id, :order_id, :document, :pages, :price])
    end

end
