class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def show
    user = User.find params[:id]
    render json: user, include: :items
  end

  def index
    render json: User.all
  end

  private

  def render_record_not_found
    render status: 404
  end

end
