class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :remove, :destroy]
  before_action -> {check_user(@rating)}, only: [:update, :edit, :remove]

  def update
    if @rating_check.update(@final_rating_params)
      flash[:notice] = "Your rating was updated!"
      redirect_to recipe_path(params[:recipe_id])
    else
      flash[:alert] = "Rating not updated! #{@rating_check.errors.full_messages.join(". ")}"
      redirect_to recipe_path(params[:recipe_id])
    end
  end

  def create
    @final_rating_params = rating_params
    @final_rating_params["rating"] = Rating::rating_array_index(rating_params["rating"])
    @final_rating_params["comment"] = rating_params["comment"].strip
    @rating_check = Rating.where({ user_id: rating_params["user_id"], recipe_id: rating_params["recipe_id"] })
    if @rating_check.count >= 1
      self.update
    else
      @rating = Rating.new(@final_rating_params)
      if @rating.save
        flash[:notice] = "Thanks for your rating!"
        redirect_to recipe_path(params[:recipe_id])
      else
        flash[:alert] = @rating.errors.full_messages.join(". ")
        redirect_to recipe_path(params[:recipe_id])
      end
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

end
