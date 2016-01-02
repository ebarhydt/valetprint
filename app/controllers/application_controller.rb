class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if session[:order].present?
      @order = current_user.orders.create(eval(session[:order])['order'])
      session[:order] = nil
      flash[:notice] = "Sweet, logged in. Nice docs, btw ;-)"
      new_order_path
    else
      # if there is not temp list in session, proceed as normal
      super
    end
  end
end
