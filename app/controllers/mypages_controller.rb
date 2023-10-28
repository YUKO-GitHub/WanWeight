class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @dogs = current_user.dogs
    @latest_user_weight = current_user.user_weights.order(date: :desc).first
  end
end
