class OrderMailer < ApplicationMailer
  def order_request(order)
    @order = order
    @items = @order.items
    mail(to: 'ethanbarhydt@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
