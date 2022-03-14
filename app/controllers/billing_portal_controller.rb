class BillingPortalController < ApplicationController
  before_action :require_user

  def create
    portal_session = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer_id,
      return_url: plans_url,
    })
    redirect_to portal_session.url
  end

end
