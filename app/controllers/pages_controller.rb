class PagesController < ApplicationController
  before_action :require_user, only: %i[plans]

  def home
    redirect_to articles_path if logged_in?
  end

  def plans
    @plans = Stripe::Price.list(
      lookup_keys: %i[premium_year premium_month],
      expand: ['data.product']).data.sort_by(&:unit_amount)
  end
end
