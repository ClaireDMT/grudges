class UserGrudgesController < ApplicationController
  def index
    @guilty = User.find(params[:user_id])
    @user_grudges = UserGrudge.where(guilty: @guilty, offended: current_user)
    @total_offenses = total_offenses_to_me(@guilty)
  end

  def new
    @user_grudge = UserGrudge.new
  end

  def create
    @user_grudge = UserGrudge.new(user_grudge_params)
    @user_grudge.offended = current_user
    if @user_grudge.save
      redirect_to user_user_grudges_path(@user_grudge.guilty)
    else
      render :new
    end
  end

  private

  def user_grudge_params
    params.require(:user_grudge).permit(:guilty_id, :grudge_id)
  end

  def total_offenses_to_me(user)
    UserGrudge.where(guilty: user, offended: current_user).joins(:grudge).sum(:points)
  end
end
