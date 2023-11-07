class DogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  def new
    @dog = current_user.dogs.build
  end

  def show
  end

  def create
    @dog = current_user.dogs.build(dog_params)
    if @dog.save
      redirect_to mypage_path, notice: '愛犬を登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dog.update(dog_params)
      redirect_to mypage_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @dog.destroy
      redirect_to mypage_path, notice: '愛犬の情報を削除しました', status: :see_other
    else
      redirect_to mypage_path, alert: '情報の削除に失敗しました。再度お試しください。'
    end
  end

  private

  def set_dog
    @dog = current_user.dogs.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:name, :birthday, :sex, :breed, :avatar)
  end
end
