class UserWeightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_weight, only: [:edit, :update, :destroy]
  before_action :initialize_user_weight, only: [:create]
  before_action :combine_date_and_time, only: [:create, :update]

  def index
    @year, @month = params[:date]&.split('-') || [Date.current.year, Date.current.month]
    start_date = Date.new(@year.to_i, @month.to_i, 1)
    end_date = start_date.end_of_month

    @user_weights = current_user.user_weights.where(date: start_date..end_date).order(date: :desc)
    @user_weights_for_graph = @user_weights.map { |weight| [weight.date.to_date, weight.weight] }.to_h
    @latest_user_weight = @user_weights.first
  end

  def new
    @user_weight = current_user.user_weights.new
  end

  def create
    combine_date_and_time
    if @user_weight.save
      redirect_to mypage_path, notice: '体重が正常に記録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    combine_date_and_time
    if @user_weight.update(user_weight_params.except(:date_part, :time_part))
      redirect_to mypage_path, notice: '体重が正常に更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_weight.destroy
    redirect_to user_weights_path, notice: '体重が正常に削除されました。'
  end

  private

  def user_weight_params
    params.require(:user_weight).permit(:weight, :date_part, :time_part)
  end

  def set_user_weight
    @user_weight = current_user.user_weights.find(params[:id])
  end

  def initialize_user_weight
    @user_weight = current_user.user_weights.new(user_weight_params.except(:date_part, :time_part))
  end

  def combine_date_and_time
    date = Date.parse(params[:user_weight][:date_part])
    time = Time.zone.parse(params[:user_weight][:time_part])
    @user_weight.date = Time.zone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end
end
