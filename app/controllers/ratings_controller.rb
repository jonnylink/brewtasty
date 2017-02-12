class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :remove, :destroy]
  before_action :authorize_user, only: [:update, :edit, :destroy]

  def index
    @ratings = Rating.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
    @rating = Rating.new
  end

  def create
    final_rating_params = rating_params
    final_rating_params["rating"] = Rating::rating_array_index(rating_params["rating"])
    final_rating_params["comment"] = rating_params["comment"].strip
    @rating = Rating.new(final_rating_params)
    if @rating.save
      flash[:notice] = "Thanks for your rating!"
      redirect_to recipe_path(params[:recipe_id])
    else
      flash[:alert] = @rating.errors.full_messages.join(". ")
      redirect_to recipe_path(params[:recipe_id])
    end
  end

  def destroy
    @rating.destroy
    redirect_to recipe_path(@rating.recipe_id), notice: "Rating deleted."
  end

  private
  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:rating, :comment, :recipe_id, :user_id)
  end

  def authorize_user
    if !current_user || current_user.id != @rating.user_id
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end
end
