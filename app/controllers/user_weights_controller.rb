class UserWeightsController < ApplicationController
  def new
    @user_weight = current_user.user_weights.new
  end

  def create
    @user_weight = current_user.user_weights.new(user_weight_params)
    if @user_weight.save
      redirect_to user_path(current_user), notice: '体重が正常に記録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user_weight = current_user.user_weights.find(params[:id])
  end

  def update
    @user_weight = current_user.user_weights.find(params[:id])
    if @user_weight.update(user_weight_params)
      redirect_to user_path(current_user), notice: '体重が正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user_weight = current_user.user_weights.find(params[:id])
    @user_weight.destroy
    redirect_to user_path(current_user), notice: '体重が正常に削除されました。'
  end

  private

  def user_weight_params
    params.require(:user_weight).permit(:weight, :date)
  end
end
