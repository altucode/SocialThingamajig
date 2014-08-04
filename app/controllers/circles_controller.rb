class CirclesController < ApplicationController
  before_action :require_current_user!, except: []
  def create
    @circle = Circle.new(circle_params)

    if @circle.save
      redirect_to user_url(current_user)
    else
      render json: @circle.errors.full_messages
    end
  end

  def index
    @circles = Circle.where(owner_id: params[:user_id])
    render :index
  end

  def new
    @circle = Circle.new
    render :new
  end

  def edit
    @circle = Circle.find(params[:id])
    render :edit
  end

  def show
    @circle = Circle.find(params[:id])
    render :show
  end

  def update
    @circle = Circle.find(params[:id])
    if @circle.update(circle_params)
      render :show
    else
      render json: @circle.errors.full_messages
    end
  end

  private
  def circle_params
    params.require(:circle).permit(:name, :owner_id, user_ids: [])
  end
end
