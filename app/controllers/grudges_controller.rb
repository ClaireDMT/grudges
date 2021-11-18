class GrudgesController < ApplicationController
  def new
    @grudge = Grudge.new
  end

  def create
    @grudge = Grudge.create(grudge_params)
    redirect_to root_path
  end

  private

  def grudge_params
    params.require(:grudge).permit(:name, :points, :category)
  end
end
