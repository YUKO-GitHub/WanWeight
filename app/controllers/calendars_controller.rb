class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def show
    start_date = params.fetch(:start_date, Date.today).to_date

    user_weights = current_user.user_weights.where(date: start_date.beginning_of_month..start_date.end_of_month)

    dog_ids = current_user.dogs.pluck(:id)
    dog_weights = DogWeight.where(dog_id: dog_ids, date: start_date.beginning_of_month..start_date.end_of_month)

    diaries = Diary.where("user_id = ? OR dog_id IN (?)", current_user.id, dog_ids).
      where(date: start_date.beginning_of_month..start_date.end_of_month)

    @start_date = start_date
    @events = user_weights + dog_weights + diaries
  end
end
