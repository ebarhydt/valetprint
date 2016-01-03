class OrderMailer < ApplicationMailer
  def order_request(order)
    @order = order
    @items = @order.items
    mail(to: 'ethanbarhydt@gmail.com', subject: 'Welcome to My Awesome Site')
  end

  def order_confirmation(order)
    @order = order
    @items = @order.items
    mail(to: @order.email, subject: 'Valet print: You\'re order is in progress')
  end
end
