class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @dogs = current_user.dogs
    @latest_user_weight = current_user.user_weights.order(date: :desc).first

    end_date = Time.current
    start_date = end_date - 28.days
    @user_weights_for_month = current_user.user_weights.where(
      date: start_date.beginning_of_day..end_date.end_of_day
    ).map { |weight| [weight.date.to_date, weight.weight] }.to_h

    @dogs_with_weights = @dogs.map do |dog|
      {
        dog: dog,
        latest_weight: dog.latest_weight,
        weights_for_month: dog.weights_for_month(start_date, end_date),
        start_date: start_date,
        end_date: end_date,
      }
    end
  end
end
