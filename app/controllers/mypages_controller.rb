class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @dogs = current_user.dogs
    @latest_user_weight = current_user.user_weights.order(date: :desc).first

    end_date = Time.current.to_date
    start_date = end_date - 1.month
    @user_weights_for_month = current_user.user_weights.where(date: start_date..end_date).map { |weight| [weight.date, weight.weight] }.to_h
  end
end
