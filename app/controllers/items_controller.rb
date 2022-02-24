class ItemsController < ApplicationController 
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def index
    if params[:user_id]
      user = User.find params[:user_id]
      items = Item.where user: user
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find params[:id]
    render json: item, status: 200
  end

  def create
    item = Item.create! items_params
    render json: item, status: 201
  end

  private

  def render_record_not_found
    render status: :not_found
  end

  def render_record_invalid
    render status: :unprocessable_entity
  end

  def items_params
    params.permit(:name,:description,:price,:user_id)
  end
end
