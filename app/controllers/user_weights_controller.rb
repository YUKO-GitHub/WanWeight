class UserWeightsController < ApplicationController
  before_action :set_user_weight, only: [:edit, :update, :destroy]

  def new
    @user_weight = current_user.user_weights.new
  end

  def create
    @user_weight = current_user.user_weights.new(user_weight_params.except(:date_part, :time_part))
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
    redirect_to mypage_path, notice: '体重が正常に削除されました。'
  end

  private

  def user_weight_params
    params.require(:user_weight).permit(:weight, :date_part, :time_part)
  end

  def combine_date_and_time
    @user_weight.date = DateTime.parse("#{params[:user_weight][:date_part]} #{params[:user_weight][:time_part]}")
  end

  def set_user_weight
    @user_weight = current_user.user_weights.find(params[:id])
  end
end
