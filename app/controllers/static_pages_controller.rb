class StaticPagesController < ApplicationController
  def plans
    @plans = Stripe::Price.list(
      lookup_keys: ['premium_year', 'premium_month'],
      expand: ['data.product'].data.sort_by { |p| p.unit_amount }
    )
  end
end
