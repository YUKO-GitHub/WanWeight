class CalendarsController < ApplicationController
  def show
    start_date = params.fetch(:start_date, Date.today).to_date

    user_weights = UserWeight.all
    dog_weights = DogWeight.all
    diaries = Diary.all

    @start_date = start_date
    @events = user_weights + dog_weights + diaries
  end
end
