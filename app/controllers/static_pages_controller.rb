class StaticPagesController < ApplicationController
  def plans
    @plans = Stripe::Price.list(lookup_keys: ['premium_year', 'premium_month'], expand: ['data.product'])
  end
end
