class CalendarsController < ApplicationController
  def show
    user_weights = UserWeight.all
    dog_weights = DogWeight.all
    diaries = Diary.all

    @events = user_weights + dog_weights + diaries
  end
end
