class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @dogs = current_user.dogs
    @latest_user_weight = current_user.user_weights.order(date: :desc).first

    user_end_date = Time.current.to_date
    user_start_date = user_end_date - 1.month
    @user_weights_for_month = current_user.user_weights.where(
      date: user_start_date.beginning_of_day..user_end_date.end_of_day
    ).map { |weight| [weight.date.to_date, weight.weight] }.to_h

    @dogs_with_weights = @dogs.map do |dog|
      dog_end_date = Time.current.to_date
      dog_start_date = dog_end_date - 1.month
      {
        dog: dog,
        latest_weight: dog.latest_weight,
        weights_for_month: dog.weights_for_month(dog_start_date, dog_end_date),
      }
    end
  end
end
