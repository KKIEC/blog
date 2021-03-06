class CheckoutController < ApplicationController
  before_action :require_user

  def create
    @session = Stripe::Checkout::Session.create(
      {
        customer: current_user.stripe_customer_id,
        success_url: articles_url,
        cancel_url: plans_url,
        payment_method_types: ['card'],
        line_items: [
          { price: params[:price], quantity: 1 }
        ],
        mode: 'subscription'
      }
    )
    respond_to do |format|
      format.js
    end
  end

end
