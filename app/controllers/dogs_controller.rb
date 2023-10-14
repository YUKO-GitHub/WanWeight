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
      redirect_to mypage_path, notice: '登録しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @dog.update(dog_params)
      redirect_to mypage_path, notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @dog.destroy
    redirect_to some_path, notice: '愛犬の情報を削除しました'
  end

  private

  def set_dog
    @dog = current_user.dogs.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:name, :birthday, :sex, :breed, :profile_image)
  end
end
