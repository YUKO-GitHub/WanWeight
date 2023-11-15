class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_date_range

  def index
    @diaries = Diary.where(user: current_user)
      .or(Diary.where(dog: current_user.dogs))
      .where(date: @start_date..@end_date)
      .order(date: :desc)
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_date_range
    @year, @month = params[:date]&.split('-') || [Date.current.year, Date.current.month]
    @start_date = Date.new(@year.to_i, @month.to_i, 1)
    @end_date = @start_date.end_of_month
  end
end
