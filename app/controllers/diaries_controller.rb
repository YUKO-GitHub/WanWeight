class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_date_range, only: :index
  before_action :set_diary, only: [:show, :edit, :update, :destroy]

  def index
    @diaries = Diary.where(user: current_user)
      .or(Diary.where(dog: current_user.dogs))
      .where(date: @start_date..@end_date)
      .order(date: :desc)
  end

  def new
    @diary = Diary.new(date: Date.current)
    @dog_options = dogs_for_select
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to diaries_path, notice: '日記が正常に作成されました。'
    else
      @dog_options = dogs_for_select
      render :new
    end
  end

  def show
    @diary_title = @diary.dog.present? ? @diary.dog.name : @diary.user.name
  end

  def edit
    @dog_options = dogs_for_select
  end

  def update
    if @diary.update(diary_params)
      redirect_to diaries_path, notice: '日記が正常に更新されました。'
    else
      @dog_options = dogs_for_select
      render :edit
    end
  end

  def destroy
  end

  private

  def diary_params
    params.require(:diary).permit(:dog_id, :date, :diary_text, :meal_text, :exercise_text, :health_text, photos: [])
  end

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def set_date_range
    @year, @month = params[:date]&.split('-') || [Date.current.year, Date.current.month]
    @start_date = Date.new(@year.to_i, @month.to_i, 1)
    @end_date = @start_date.end_of_month
  end

  def dogs_for_select
    dogs = current_user.dogs.map { |d| [d.name, d.id] }
    dogs.unshift(['ユーザー', nil])
  end
end
