class DogWeightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dog
  before_action :set_dog_weight, only: [:edit, :update, :destroy]
  before_action :initialize_dog_weight, only: [:create]
  before_action :combine_date_and_time, only: [:create, :update]

  def index
    @year, @month = params[:date]&.split('-') || [Date.current.year, Date.current.month]
    start_date = Date.new(@year.to_i, @month.to_i, 1)
    end_date = start_date.end_of_month

    @dog_weights = @dog.dog_weights.where(date: start_date..end_date).order(date: :desc)
    @dog_weights_for_graph = @dog_weights.map { |weight| [weight.date.to_date, weight.weight] }.to_h
    @latest_dog_weight = @dog_weights.first
  end

  def new
    @dog_weight = @dog.dog_weights.new
  end

  def create
    combine_date_and_time
    if @dog_weight.save
      redirect_to mypage_path, notice: '愛犬の体重が正常に記録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    combine_date_and_time
    if @dog_weight.update(dog_weight_params.except(:date_part, :time_part))
      redirect_to dog_dog_weights_path(@dog), notice: '愛犬の体重が正常に更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dog_weight.destroy
    redirect_to dog_dog_weights_path(@dog), notice: '愛犬の体重が正常に削除されました。'
  end

  private

  def set_dog
    @dog = current_user.dogs.find(params[:dog_id])
  end

  def dog_weight_params
    params.require(:dog_weight).permit(:weight, :date_part, :time_part)
  end

  def set_dog_weight
    @dog_weight = @dog.dog_weights.find(params[:id])
  end

  def initialize_dog_weight
    @dog_weight = @dog.dog_weights.new(dog_weight_params.except(:date_part, :time_part))
  end

  def combine_date_and_time
    if params[:dog_weight][:date_part].present? && params[:dog_weight][:time_part].present?
      date = Date.parse(params[:dog_weight][:date_part])
      time = Time.zone.parse(params[:dog_weight][:time_part])
      @dog_weight.date = Time.zone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)
    end
  end
end
