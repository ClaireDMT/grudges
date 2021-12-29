class UsersController < ApplicationController
  def index
    @friends = current_user.relations
    @users = User.all
    if params[:query]
      sql_query = "username ILIKE :query OR email ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%") if params[:query].present?
    end
  end
end
